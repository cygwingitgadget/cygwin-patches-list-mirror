Return-Path: <cygwin-patches-return-3475-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8349 invoked by alias); 3 Feb 2003 00:37:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8339 invoked from network); 3 Feb 2003 00:37:57 -0000
Message-ID: <3E3DB9D1.8080909@yahoo.com>
Date: Mon, 03 Feb 2003 00:37:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To:  cygwin-patches@cygwin.com
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mumit Khan <khan@nanotech.wisc.edu>
CC:  cygwin-patches@cygwin.com
Subject: Re: [patch] Tcl 20030128-3 changes to handle Cygwin pathnames
References: <Pine.HPX.4.33.0302021802560.18077-100000@hp2.xraylith.wisc.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00124.txt.bz2

Hi Mumit,

If cygwin specific code already exists in the official source then I 
suggest you submit your patch to the tcl.sf.net project.

Earnie.

Mumit Khan wrote:
> Jeff Hobbs had put in some of my changes that allows Cygwin pathnames
> into Tcl 8.3.5, but it doesn't work with the new filesystem code in Tcl
> 8.4. The new filesystem code does make it a bit easier to support such
> "non-native" filenames. Hopefully these will go into Tcl core at some
> point.
> 
> The 3 cases that the appended patch fixes:
> 
> 1. Translate Cygwin POSIX path correctly into native form.
> 
>    $ /usr/local/tcl8.4.1-redhat/bin/tclsh84 /tmp/foo.tcl
> 
>    will do the right thing.
> 
>    $ /usr/local/tcl8.4.1-redhat/bin/tclsh84
>    % file native /
>    C:\cygwin
>    %
> 
> 2. Support globbing with Cygwin POSIX pathnames.
> 
>    $ /usr/local/tcl8.4.1-redhat/bin/tclsh84
>    % glob /
>    C:/cygwin
>    % glob /home
>    C:/cygwin/home
>    % glob "/home/Mumit Khan/.bash*"
>    {C:/cygwin/home/Mumit Khan/.bash_profile}
> 
> 3. Chdir. Use Cygwin's chdir to keep the internal state consistent.
> 
> 2003-02-02  Mumit Khan  <khan@nanotech.wisc.edu>
> 
> 	* generic/tclIOUtil.c (SetFsPathFromAny): Add Cygwin specific
> 	code to convert POSIX filename to native format.
> 	* generic/tclFileName.c (Tcl_TranslateFileName): And remove
> 	from here.
> 	(TclDoGlob): Adjust.
> 	* win/tclWinFile.c (TclpObjChdir): Use chdir on Cygwin.
> 
> Index: generic/tclFileName.c
> ===================================================================
> RCS file: /home/khan/src/tcltk/CVSROOT/tcltk8.4.1/tcl/generic/tclFileName.c,v
> retrieving revision 1.1.1.1
> diff -u -3 -p -r1.1.1.1 tclFileName.c
> --- generic/tclFileName.c	2003/01/31 22:26:16	1.1.1.1
> +++ generic/tclFileName.c	2003/02/02 04:37:23
> @@ -1356,31 +1356,12 @@ Tcl_TranslateFileName(interp, name, buff
>       */
> 
>      if (tclPlatform == TCL_PLATFORM_WINDOWS) {
> -#if defined(__CYGWIN__) && defined(__WIN32__)
> -
> -	extern int cygwin_conv_to_win32_path
> -	    _ANSI_ARGS_((CONST char *, char *));
> -	char winbuf[MAX_PATH];
> -
> -	/*
> -	 * In the Cygwin world, call conv_to_win32_path in order to use the
> -	 * mount table to translate the file name into something Windows will
> -	 * understand.  Take care when converting empty strings!
> -	 */
> -	if (Tcl_DStringLength(bufferPtr)) {
> -	    cygwin_conv_to_win32_path(Tcl_DStringValue(bufferPtr), winbuf);
> -	    Tcl_DStringFree(bufferPtr);
> -	    Tcl_DStringAppend(bufferPtr, winbuf, -1);
> -	}
> -#else /* __CYGWIN__ && __WIN32__ */
> -
>  	register char *p;
>  	for (p = Tcl_DStringValue(bufferPtr); *p != '\0'; p++) {
>  	    if (*p == '/') {
>  		*p = '\\';
>  	    }
>  	}
> -#endif /* __CYGWIN__ && __WIN32__ */
>      }
>      return Tcl_DStringValue(bufferPtr);
>  }
> @@ -2336,25 +2317,6 @@ TclDoGlob(interp, separators, headPtr, t
>  	     * element.  Add an extra slash if this is a UNC path.
>  	     */
> 
> -#if defined(__CYGWIN__) && defined(__WIN32__)
> -	    {
> -
> -	    extern int cygwin_conv_to_win32_path
> -	    	_ANSI_ARGS_((CONST char *, char *));
> -	    char winbuf[MAX_PATH];
> -
> -	    /*
> -	     * In the Cygwin world, call conv_to_win32_path in order to use
> -	     * the mount table to translate the file name into something
> -	     * Windows will understand.
> -	     */
> -	    cygwin_conv_to_win32_path(Tcl_DStringValue(headPtr), winbuf);
> -	    Tcl_DStringFree(headPtr);
> -	    Tcl_DStringAppend(headPtr, winbuf, -1);
> -
> -	    }
> -#endif /* __CYGWIN__ && __WIN32__ */
> -
>  	    if (*name == ':') {
>  		Tcl_DStringAppend(headPtr, ":", 1);
>  		if (count > 1) {
> @@ -2570,11 +2532,24 @@ TclDoGlob(interp, separators, headPtr, t
>  		if (Tcl_DStringLength(headPtr) == 0) {
>  		    if (((*name == '\\') && (name[1] == '/' || name[1] == '\\'))
>  			    || (*name == '/')) {
> -			Tcl_DStringAppend(headPtr, "\\", 1);
> +			Tcl_DStringAppend(headPtr, "/", 1);
>  		    } else {
>  			Tcl_DStringAppend(headPtr, ".", 1);
>  		    }
>  		}
> +#if defined(__CYGWIN__) && defined(__WIN32__)
> +		{
> +
> +		extern int cygwin_conv_to_win32_path
> +		    _ANSI_ARGS_((CONST char *, char *));
> +		char winbuf[MAX_PATH+1];
> +
> +		cygwin_conv_to_win32_path(Tcl_DStringValue(headPtr), winbuf);
> +		Tcl_DStringFree(headPtr);
> +		Tcl_DStringAppend(headPtr, winbuf, -1);
> +
> +		}
> +#endif /* __CYGWIN__ && __WIN32__ */
>  		/*
>  		 * Convert to forward slashes.  This is required to pass
>  		 * some Tcl tests.  We should probably remove the conversions
> Index: generic/tclIOUtil.c
> ===================================================================
> RCS file: /home/khan/src/tcltk/CVSROOT/tcltk8.4.1/tcl/generic/tclIOUtil.c,v
> retrieving revision 1.1.1.1
> diff -u -3 -p -r1.1.1.1 tclIOUtil.c
> --- generic/tclIOUtil.c	2003/01/31 22:26:18	1.1.1.1
> +++ generic/tclIOUtil.c	2003/02/03 00:16:51
> @@ -3947,6 +3947,28 @@ SetFsPathFromAny(interp, objPtr)
>  	transPtr = Tcl_FSJoinToPath(objPtr,0,NULL);
>      }
> 
> +#if defined(__CYGWIN__) && defined(__WIN32__)
> +    {
> +
> +    extern int cygwin_conv_to_win32_path
> +	_ANSI_ARGS_((CONST char *, char *));
> +    char winbuf[MAX_PATH+1];
> +
> +    /*
> +     * In the Cygwin world, call conv_to_win32_path in order to use the
> +     * mount table to translate the file name into something Windows will
> +     * understand.  Take care when converting empty strings!
> +     */
> +    name = Tcl_GetStringFromObj(transPtr, &len);
> +    if (len > 0) {
> +	cygwin_conv_to_win32_path(name, winbuf);
> +	TclWinNoBackslash(winbuf);
> +	Tcl_SetStringObj(transPtr, winbuf, -1);
> +    }
> +
> +    }
> +#endif /* __CYGWIN__ && __WIN32__ */
> +
>      /*
>       * Now we have a translated filename in 'transPtr'.  This will have
>       * forward slashes on Windows, and will not contain any ~user
> Index: win/tclWinFile.c
> ===================================================================
> RCS file: /home/khan/src/tcltk/CVSROOT/tcltk8.4.1/tcl/win/tclWinFile.c,v
> retrieving revision 1.1.1.1
> diff -u -3 -p -r1.1.1.1 tclWinFile.c
> --- win/tclWinFile.c	2003/01/31 22:27:10	1.1.1.1
> +++ win/tclWinFile.c	2003/02/01 01:01:15
> @@ -1330,9 +1330,25 @@ TclpObjChdir(pathPtr)
>  {
>      int result;
>      CONST TCHAR *nativePath;
> +#ifdef __CYGWIN__
> +    extern int cygwin_conv_to_posix_path
> +	_ANSI_ARGS_((CONST char *, char *));
> +    char posixPath[MAX_PATH+1];
> +    CONST char *path;
> +    Tcl_DString ds;
> +#endif /* __CYGWIN__ */
> 
> +
>      nativePath = (CONST TCHAR *) Tcl_FSGetNativePath(pathPtr);
> +#ifdef __CYGWIN__
> +    /* Cygwin chdir only groks POSIX path. */
> +    path = Tcl_WinTCharToUtf(nativePath, -1, &ds);
> +    cygwin_conv_to_posix_path(path, posixPath);
> +    result = (chdir(posixPath) == 0 ? 1 : 0);
> +    Tcl_DStringFree(&ds);
> +#else /* __CYGWIN__ */
>      result = (*tclWinProcs->setCurrentDirectoryProc)(nativePath);
> +#endif /* __CYGWIN__ */
> 
>      if (result == 0) {
>  	TclWinConvertError(GetLastError());
> 
