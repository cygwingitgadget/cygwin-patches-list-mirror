Return-Path: <cygwin-patches-return-6013-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18655 invoked by alias); 10 Dec 2006 09:16:21 -0000
Received: (qmail 18645 invoked by uid 22791); 10 Dec 2006 09:16:20 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.gmx.net (HELO mail.gmx.net) (213.165.64.20)     by sourceware.org (qpsmtpd/0.31) with SMTP; Sun, 10 Dec 2006 09:16:10 +0000
Received: (qmail invoked by alias); 10 Dec 2006 09:16:07 -0000
Received: from p549164F4.dip.t-dialin.net (EHLO p549164F4.dip.t-dialin.net) [84.145.100.244]   by mail.gmx.net (mp046) with SMTP; 10 Dec 2006 10:16:07 +0100
X-Authenticated: #1350826
Date: Sun, 10 Dec 2006 09:16:00 -0000
From: =?iso-8859-15?Q?Franz_H=E4uslschmid?= <lukrez@gmx.at>
To: cygwin-patches@cygwin.com
Subject: EPS import for XFig
Message-ID: <alpine.DEB.0.8.0612101013260.4352@pan.haeuslsc.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00031.txt.bz2

Hello,

there is a problem with XFig as soon as more than one EPS should
be imported as figure object.  The problem has been addressed
earlier:

  <http://article.gmane.org/gmane.os.cygwin.xfree/14757>

  <http://thread.gmane.org/gmane.os.cygwin/40818>

and finally

  <http://article.gmane.org/gmane.os.cygwin/69899>

An inspection of XFig's source code revealed that a call to
`unlink' in order to remove a temporary bitmap preview of the EPS
to include delays the actual deletion.  The bitmap preview for
subsequent EPS files would go to a temporary file always having
the same name.  As the deletion of the first preview is pending
(which means that the preview file is still there, without any
file permissions observable by Windows Explorer), subsequent
previews having the same file name can't be created and the
import into the editor view fails.

The cause for the delay of the deletion is, that there is still a
`FILE' object in memory that references that file.  The patch
forces the file to be closed as soon as it isn't needed any more.

Regards,
Franz.

2006-12-10  Franz Haeuslschmid  <lukrez@gmx.at>

	    * f_readeps.c (bitmap_from_gs): Ensures that all FILE
	      objects
	      referring to the temporary bitmap preview are
	      closed before the
	      preview file is unlinked.

--- f_readeps.c.orig  2005-10-05 11:17:05.985950000 +0200
+++ f_readeps.c	      2005-10-05 11:19:29.095325000 +0200
@@ -407,6 +407,7 @@ Boolean
         ht = pic->pic_cache->size_y;
         pcxfile = open_picfile(pixnam, &filtyp, PIPEOK,
         tmpfile);
         status = _read_pcx(pcxfile, pic);
+        fclose(pcxfile);
         /* restore width/height */
         pic->pic_cache->size_x = wid;
         pic->pic_cache->size_y = ht;
