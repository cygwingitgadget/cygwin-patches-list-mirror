Return-Path: <cygwin-patches-return-5098-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18712 invoked by alias); 29 Oct 2004 15:22:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18700 invoked from network); 29 Oct 2004 15:22:25 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 29 Oct 2004 15:22:25 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 66BD11B3E5; Fri, 29 Oct 2004 11:22:38 -0400 (EDT)
Date: Fri, 29 Oct 2004 15:22:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: Don't use keyeprint if GetLastError is irrelevant.
Message-ID: <20041029152238.GG29869@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.clsnoj.3vvasbt.1@buzzy-box.bavag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2m-g.clsnoj.3vvasbt.1@buzzy-box.bavag>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00099.txt.bz2

On Fri, Oct 29, 2004 at 06:31:11AM +0200, Bas van Gompel wrote:
>Following (trivial, once more, I hope) patch cleans up some of the
>(IMO) inappropriate ``keyeprint'' usage in cygcheck. It (keyeprint)
>should not be used when GetLastError does not apply, I think. Also the
>format ending in ``failed'' can cause strange messages like ``NULL
>pointer for file failed''.

If malloc failed, it is not inconceivable that there is a system error.

Since the point of keyeprint is to print error messages, reverting to
using raw puts is a step backwards.  If it is really known that there is
not a remote possibility that GetLastError will be useful, then an
option to keyeprint should be added.  I'd rather regularize error output
throughout cygcheck (which may be a bigger job than your current assignment
status will allow) than sprinkle fputs's, and fprints's around the code.

cgf

>While doing this I caught a typo in get_dword.
>
>
>ChangeLog-entry:
>
>2004-10-28  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>
>
>	* cygcheck.cc (add_path): Don't use keyeprint when GetLastError is
>	irrelevant.
>	(find_on_path): Ditto.
>	(rva_to_offset): Ditto.
>	(cygwin_info): Ditto.
>	(get_dword): Fix typo in errormessage.
>
>
>--- src/winsup/utils/cygcheck.cc	27 Oct 2004 01:28:07 -0000	1.58
>+++ src/winsup/utils/cygcheck.cc	29 Oct 2004 03:34:15 -0000
>@@ -122,7 +122,7 @@ add_path (char *s, int maxlen)
>   paths[num_paths] = (char *) malloc (maxlen + 1);
>   if (paths[num_paths] == NULL)
>     {
>-      keyeprint ("add_path: malloc()");
>+      fputs ("cygcheck: add_path: malloc() failed", stderr);
>       return;
>     }
>   memcpy (paths[num_paths], s, maxlen);
>@@ -185,13 +185,14 @@ find_on_path (char *file, char *default_
> 
>   if (!file)
>     {
>-      keyeprint ("find_on_path: NULL pointer for file");
>+      fputs ("cygcheck: find_on_path: NULL pointer for file", stderr);
>       return 0;
>     }
> 
>   if (default_extension == NULL)
>     {
>-      keyeprint ("find_on_path: NULL pointer for default_extension");
>+      fputs ("cygcheck: find_on_path: NULL pointer for default_extension",
>+	    stderr);
>       return 0;
>     }
> 
>@@ -276,7 +277,7 @@ get_dword (HANDLE fh, int offset)
> 
>   if (SetFilePointer (fh, offset, 0, FILE_BEGIN) == INVALID_SET_FILE_POINTER
>       && GetLastError () != NO_ERROR)
>-    keyeprint ("get_word: SetFilePointer()");
>+    keyeprint ("get_dword: SetFilePointer()");
> 
>   if (!ReadFile (fh, &rv, 4, (DWORD *) &r, 0))
>     keyeprint ("get_dword: Readfile()");
>@@ -300,7 +301,7 @@ rva_to_offset (int rva, char *sections, 
> 
>   if (sections == NULL)
>     {
>-      keyeprint ("rva_to_offset: NULL passed for sections");
>+      fputs ("cygcheck: rva_to_offset: NULL passed for sections", stderr);
>       return 0;
>     }
> 
>@@ -359,7 +360,7 @@ cygwin_info (HANDLE h)
>   buf_start = buf = (char *) calloc (1, size + 1);
>   if (buf == NULL)
>     {
>-      keyeprint ("cygwin_info: malloc()");
>+      fputs ("cygcheck: cygwin_info: calloc() failed", stderr);
>       return;
>     }
> 
>
>
>L8r,
>
>Buzz.
>-- 
>  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
>--  |  |   /    /   really is |   and false bits entirely.    | mail for
>  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
>--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
