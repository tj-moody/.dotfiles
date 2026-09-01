"
" Keep versions of files in EECS 482 github repos
"

" return relative time
function version482#RelTime()
    return(reltimestr(reltime())->substitute('\.\(...\).*', '\1', '') / 1000)
endfunction

let $TZ='America/Detroit'
let $SSH_ASKPASS='echo'
let $SSH_ASKPASS_REQUIRE='force'
let s:startTimeAbs = localtime()
let s:startTimeRel = version482#RelTime()

" return absolute time
function version482#Time()
    return(s:startTimeAbs + (version482#RelTime() - s:startTimeRel))
endfunction

let s:version = 'vim-20260824'
let s:minTimeVersion = 10       " minimum time between versions
let s:minTimePush = 60          " minimum time between pushes
let s:minTimeCheck = 600        " minimum time between checking version482 repos

let s:versionTime = {}          " last time each file was written
let s:pushTime = {}             " last time each repo was pushed
let s:checkTime = 0             " last time version482 repos were checked

let s:timerStarted = 0
let s:pushTimerStarted = 0

let s:versionDir = {}     " version482 directory name for each source file directory

autocmd BufReadPost * call version482#NewBuffer()
autocmd BufWritePre * call version482#Save()
autocmd TextChanged,TextChangedI * call version482#TextChanged()

" See if directory is in an EECS 482 git repo.
" Store version482 directory name in s:versionDir, and make sure the
" version482 directory exists and is properly configured.  If the directory
" isn't in a git repo, then set the versionDir entry to the empty string.
function version482#InitVersionDir(dirname)
    if has_key(s:versionDir, a:dirname)
        return
    endif

    let s:versionDir[a:dirname] = ''
    let l:dateString = strftime("%Y.%m.%d_%H.%M.%S", version482#Time())

    " Get top level of working tree
    let l:top = trim(system('git -C "' . a:dirname . '" rev-parse --show-toplevel'))
    if v:shell_error
        " Not in a git repository
        return
    endif

    " Get name of main repo and make sure it's an eecs482 repo
    let l:origin = trim(system('git -C "' . a:dirname . '" remote get-url origin'))
    let l:matches = matchlist(l:origin, '^\(git@github.com:\|https://github.com/\)\(eecs482/[a-z.]*\d\d*\)\(.*\)')
    if empty(l:matches)
        " Not in an eecs482 repo
        return
    endif

    let l:protocol = l:matches[1]
    let l:repo = l:matches[2]
    let l:suffix = l:matches[3]

    " Make sure top level is not a version482 repo
    if stridx(l:origin, 'version482') >= 0
        " In a version482 repo
	echo 'Error: trying to edit file in a version482 repo'
	bdelete
        return
    endif

    " Compute correct branch for this local version482 repo
    let l:branch = $USER . substitute(hostname(), '\..*', "", "") . trim(system('uname -s'))
    if filereadable('/etc/os-release')
	let l:branch .= trim(system('grep "^ID=" /etc/os-release | sed "s/^.*=//"'))
    endif
    let l:branch .= l:top
    let l:branch = substitute(l:branch, "[^a-zA-Z0-9]", "", "g")

    let s:versionDir[a:dirname] = fnamemodify(l:top, ':p') . '.version482.' . l:branch

    " Check version482 repository and move it aside if broken
    try
	" Make sure version482 exists and is a directory
	if ! isdirectory(s:versionDir[a:dirname])
	    throw 'Error: ' . s:versionDir[a:dirname] . ' does not exist or is not a directory.'
	endif

	" Make sure version482 is its own repo
	let l:version482Top = trim(system('git -C "' . s:versionDir[a:dirname] . '" rev-parse --show-toplevel'))
	if v:shell_error
	    throw 'Error: ' . s:versionDir[a:dirname] . ' is not in a work tree.'
	elseif l:version482Top != s:versionDir[a:dirname]
	    throw 'Error: ' . s:versionDir[a:dirname] . ' is not its own repository.'
	endif

	" Make sure origin for version482 repo is consistent with origin for
	" main repo
	let l:url = trim(system('git -C "' . s:versionDir[a:dirname] . '" remote get-url origin'))
	if v:shell_error || l:url != l:protocol . l:repo . '.version482' . l:suffix
	    throw 'Error: origin for ' . s:versionDir[a:dirname] . ' is inconsistent with origin for main repo'
	endif

	" Make sure version482 repo is on the correct branch
	let l:branch1 = trim(system('git -C "' . s:versionDir[a:dirname] . '" branch --show-current'))
	if l:branch1 != l:branch
	    throw 'Error: ' . s:versionDir[a:dirname] . ' is on wrong branch ' . l:branch1
	endif

	" Make sure version482 repo's upstream is set to the corresponding
	" branch on github
	let l:remote = trim(system('git -C "' . s:versionDir[a:dirname] . '" rev-parse --abbrev-ref "@{upstream}"'))
	if v:shell_error || l:remote != "origin/" . l:branch
	    throw 'Error: ' . s:versionDir[a:dirname] . ' has the wrong upstream'
	endif

	" Make sure I can add a file in the version482 repo
	call system('touch "' . fnamemodify(s:versionDir[a:dirname], ':p') . 'tmp.' . l:dateString . '"; git -C "' . s:versionDir[a:dirname] . '" add -f "tmp.' . l:dateString . '"')
	if v:shell_error
	    throw 'Error: Cannot add tmp.' . l:dateString . ' in version482 repository.'
	endif

	" Make sure I can remove a file in the version482 repo
	call system('git -C "' . s:versionDir[a:dirname] . '" rm -f -q "tmp.' . l:dateString . '"')
	if v:shell_error
	    throw 'Error: Cannot remove tmp.' . l:dateString . ' in version482 repository.'
	endif

    catch /.*/
        " echo v:exception
	" Move the broken version482 repository aside (if it exists)
	if filereadable(s:versionDir[a:dirname]) || isdirectory(s:versionDir[a:dirname])
	    let l:oldDir = s:versionDir[a:dirname] . '.' . l:dateString
	    while (filereadable(l:oldDir) || isdirectory(l:oldDir))
		let l:oldDir .= '.'
	    endwhile
	    if rename(s:versionDir[a:dirname], l:oldDir)
		" echo 'Error: Cannot rename ' . s:versionDir[a:dirname] . ' to ' . l:oldDir
		let s:versionDir[a:dirname] = ''
		return
	    endif
	endif

    endtry

    if ! isdirectory(s:versionDir[a:dirname])
	" Clone and set up version482 repo
	try
	    call system('git -C "' . l:top . '" clone "' . l:protocol . l:repo . '.version482' . l:suffix . '" ' . s:versionDir[a:dirname])
	    if v:shell_error
		throw 'Error: cannot clone version482 repository.'
	    endif

	    " Try to checkout branch, in case this branch already exists
	    call system('git -C "' . s:versionDir[a:dirname] . '" checkout ' . l:branch)
	    if v:shell_error
		" Branch didn't exist (this is the common case)

		" Create new branch
		call system('git -C "' . s:versionDir[a:dirname] . '" checkout -b ' . l:branch . ' --no-track')
		if v:shell_error
		    throw 'Error: cannot create branch ' . l:branch . ' for version482 repo.'
		endif

		" Set upstream to github, and create branch on github
		call system('git -C "' . s:versionDir[a:dirname] . '" push --set-upstream origin ' . l:branch)
		if v:shell_error
		    throw 'Error: cannot add upstream reference to remote version482 repo'
		endif
	    endif

	catch /.*/
	    echo v:exception
	    let s:versionDir[a:dirname] = ''
	endtry
    endif

endfunction

function version482#NewBuffer()
    if ! has('nvim')
        " helps remove display glitches on startup
        sleep 100m
    endif
    call version482#InitVersionDir(fnamemodify(expand('%'), ':p:h'))
endfunction

function version482#TextChanged(...)
    let l:now = version482#Time()
    let l:filename = fnamemodify(expand('%'), ':p')

    " Limit the rate of versioning events.  Also log events where time has
    " gone backward by more than minTimeVersion.
    if has_key(s:versionTime, l:filename) && abs(l:now - s:versionTime[l:filename]) < s:minTimeVersion

        " make sure this version is eventually saved
        " replace any pending timer event, so these don't pile up
        if s:timerStarted
            call timer_stop(s:timer)
        endif
        let s:timerStarted = 1
        let s:timer = timer_start((s:minTimeVersion - (l:now - s:versionTime[l:filename]))*1000, 'version482#TextChanged')
        return
    endif

    let l:dirname = fnamemodify(l:filename, ':h')

    call version482#InitVersionDir(l:dirname)

    " make sure file is in an EECS 482 git repo
    if s:versionDir[l:dirname] == ''
        return
    endif

    " make sure file is a program source file, i.e., has extension {cpp,cc,h,hpp,py}
    let l:ext = fnamemodify(l:filename, ':e')
    if l:ext != 'cpp' && l:ext != 'cc' && l:ext != 'h' && l:ext != 'hpp' && l:ext != 'py'
        return
    endif

    let l:versionDirname = s:versionDir[l:dirname]

    " create/update file
    let l:basename = fnamemodify(l:filename, ':t')
    call writefile(getline(1, '$'), fnamemodify(l:versionDirname, ':p') . l:basename)

    " add file
    call system('git -C "' . l:versionDirname . '" add -f "' . l:basename . '"')

    " commit changes
    call system('git -C "' . l:versionDirname . '" commit --allow-empty -m "'. s:version . '"')

    let s:versionTime[l:filename] = l:now

    if ! has('nvim')
        " Redraw screen to fix glitches.  Unfortunately, this has the
        " side effect of blanking the entire screen when changing a range
        " of text (e.g., change word).  nvim doesn't have these problems.
        mode
    endif

endfunction

" called when a file is saved
function version482#Save(...)
    let l:now = version482#Time()
    let l:filename = fnamemodify(expand('%'), ':p')
    let l:dirname = fnamemodify(l:filename, ':h')

    " Clear s:versionDir every so often, so the version482 repo gets re-checked.
    if l:now - s:checkTime >= s:minTimeCheck
        let s:versionDir = {}
	let s:checkTime = l:now
    endif

    call version482#InitVersionDir(l:dirname)

    " make sure file is in an EECS 482 git repo
    if s:versionDir[l:dirname] == ''
        return
    endif
    let l:versionDirname = s:versionDir[l:dirname]

    " limit the rate of pushing
    if has_key(s:pushTime, l:versionDirname) && l:now - s:pushTime[l:versionDirname] < s:minTimePush

        " make sure this event is eventually pushed
        " replace any pending timer event, so these don't pile up
        if s:pushTimerStarted
            call timer_stop(s:pushTimer)
        endif
        let s:pushTimerStarted = 1
        let s:pushTimer = timer_start((s:minTimePush - (l:now - s:pushTime[l:versionDirname]))*1000, 'version482#Save')
        return
    endif

    " add version482 entry, so it's as new as the saved file
    call version482#TextChanged()

    " push to github
    call system('git -C "' . l:versionDirname . '" push --quiet &')
    if ! v:shell_error
	let s:pushTime[l:versionDirname] = l:now
    endif

endfunction

