From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: preliminary patch2 for i18n: change the code page to ANSI.
Date: Mon, 03 Jul 2000 19:05:00 -0000
Message-id: <s1s8zviodkm.fsf@jaist.ac.jp>
References: <s1saefyooqa.fsf@jaist.ac.jp> <20000703190459.A30846@cygnus.com>
X-SW-Source: 2000-q3/msg00003.html

>>> On Mon, 3 Jul 2000 19:04:59 -0400
>>> Chris Faylor <cgf@cygnus.com> said:

> >-      if (ich == 0 || (ich & 0xff) == 0xe0)  /* arrow/function keys */
> >+      if (ich == 0 ||
> >+	  /* arrow/function keys */
> >+	  (input_rec.Event.KeyEvent.dwControlKeyState & ENHANCED_KEY))
> > 	{
> > 	  toadd = get_nonascii_key (input_rec);
> > 	  if (!toadd)
> 
> Have you tested this change under Windows 95/98?

Yes, I tested it under Windows 98 and found it to work fine.

> This test against 0xe0 was a recent addition from someone who
> claimed that it made things work better under 95 or 98, I
> believe.

You are right. Before you added the test against 0xe0, this test
was done only against 0. It couldn't distinguish extended keys
under Win9x.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
