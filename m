Return-Path: <cygwin-patches-return-1886-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29670 invoked by alias); 25 Feb 2002 02:03:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29502 invoked from network); 25 Feb 2002 02:03:09 -0000
Message-ID: <030601c1bda0$89fb0130$5c00a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: "Robert Collins" <robert.collins@itdomain.com.au>,
	<cygwin-patches@cygwin.com>
References: <m31yfhdpkf.fsf@appel.lilypond.org><009201c1b9f9$99575fc0$0200a8c0@lifelesswks> <m3r8ng0wex.fsf@appel.lilypond.org> <018a01c1ba55$ff233b10$0200a8c0@lifelesswks> <02db01c1ba65$936be6f0$f400a8c0@mchasecompaq> <014001c1bd20$45424a60$0200a8c0@lifelesswks> <004d01c1bd8d$c0fcdcc0$5c00a8c0@mchasecompaq> <04ba01c1bd9a$926c7840$0200a8c0@lifelesswks>
Subject: Re: [Patch]setup.exe type prefixes for io_stream::mkpath_p and io_stream:open paths
Date: Sun, 24 Feb 2002 18:04:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00243.txt.bz2

----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>; <cygwin-patches@cygwin.com>
Sent: Sunday, February 24, 2002 17:20
Subject: Re: [Patch]setup.exe type prefixes for io_stream::mkpath_p and
io_stream:open paths


> Thanks Michael - I've applied a slight variation (cygfile:// is the
> appropriate prefix for the io_stream_cygfile links) to the setup200202
> branch. For HEAD we should actually start using io_streams in desktop.cc
> which will remove the need for cygpath usage. Rather than renaming
> cygpath (which is consistent with cygwin's innards, and the cygpath
> commandline util) I'd like to finish getting everything to use
> io_stream's cygfile:// syntax.

If you are going to use "cygfile://" then you shouldn't be calling
cygpath().
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/io_stream_cygfile.cc,v
retrieving revision 2.9
retrieving revision 2.9.2.1
diff -u -r2.9 -r2.9.2.1
--- src/winsup/cinstall/io_stream_cygfile.cc	2002/02/18 13:53:06	2.9
+++ src/winsup/cinstall/io_stream_cygfile.cc	2002/02/25 01:16:58	2.9.2.1
@@ -128,16 +128,16 @@
 	/* textmode alert: should we translate when linking from an binmode to a
 	   text mode mount and vice verca?
 	 */
-	io_stream *in = io_stream::open (cygpath (to), "rb");
+	io_stream *in = io_stream::open (String ("cygfile://") + cygpath (to),
"rb");
 	if (!in)
 	  {
 	    log (LOG_TIMESTAMP, String("could not open ") + to +" for reading in
mklink");
 	    return 1;
 	  }
-	io_stream *out = io_stream::open (cygpath (from), "wb");
+	io_stream *out = io_stream::open (String ("cygfile://") + cygpath (from),
"wb");
 	if (!out)
 	  {
-- Mac :})** I normally forward private questions to the appropriate mail
list. **Ask Smarter:
http://www.tuxedo.org/~esr/faqs/smart-questions.htmlGive a hobbit a fish and
he eats fish for a day.Give a hobbit a ring and he eats fish for an age.

