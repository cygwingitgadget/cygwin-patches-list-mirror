From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: preliminary patch2 for i18n: change the code page to ANSI.
Date: Mon, 03 Jul 2000 16:05:00 -0000
Message-id: <20000703190459.A30846@cygnus.com>
References: <s1saefyooqa.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00002.html

On Tue, Jul 04, 2000 at 07:03:57AM +0900, Kazuhiro Fujieda wrote:
>Index: fhandler_console.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
>retrieving revision 1.8
>diff -u -p -r1.8 fhandler_console.cc
>--- fhandler_console.cc	2000/04/24 21:41:11	1.8
>+++ fhandler_console.cc	2000/07/03 14:19:32
>@@ -179,7 +179,9 @@ fhandler_console::read (void *pv, size_t
> 	  !input_rec.Event.KeyEvent.bKeyDown)
> 	continue;
> 
>-      if (ich == 0 || (ich & 0xff) == 0xe0)  /* arrow/function keys */
>+      if (ich == 0 ||
>+	  /* arrow/function keys */
>+	  (input_rec.Event.KeyEvent.dwControlKeyState & ENHANCED_KEY))
> 	{
> 	  toadd = get_nonascii_key (input_rec);
> 	  if (!toadd)

Have you tested this change under Windows 95/98?  This test against 0xe0
was a recent addition from someone who claimed that it made things work
better under 95 or 98, I believe.

cgf
