Return-Path: <cygwin-patches-return-1778-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10239 invoked by alias); 25 Jan 2002 01:49:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10221 invoked from network); 25 Jan 2002 01:49:07 -0000
Message-ID: <003f01c1a542$742968e0$a100a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH]Package extention recognition
Date: Thu, 24 Jan 2002 17:49:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00135.txt.bz2

I noticed that find_tar_ext() always returns after checking for ".tar.bz2"
and ".tar.gz" so it never gets to the check for ".tar".  As long as I was
fixing that, it seemed like a good time to add ".cwp" as an accepted file
extension.

I also updated the code in fromcwd.cc so it can accept any extension found
by find_tar_ext() if it is ever reactivated.  I think it might be better if
no msg() call is made if no "-src" file is found and I also think the fall
back to "-src.tar.bz2" or "-src.tar.gz" could be dispensed with.  I left
those in for now in case someone really wanted them.

The code compiles successfully into setup.exe 2.184.  I successfully
downloaded and installed 3 packages with the new setup.exe.
--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

ChangeLog:

2002-01-24  Michael A Chase <mchase@ix.netcom.com>

    * filemanip.cc (find_tar_ext): Recognize file extensions .tar and .cwd
in
    addition to .tar.gz and .tar.bz2.
    * fromcwd.cc (do_fromcwd): Try same extension as binary archive for -src
    archive before falling back to .tar.bz2 or .tar.gz.
    * install.cc (install_one_source): Add space between words in log()
call.


