Return-Path: <cygwin-patches-return-1592-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1913 invoked by alias); 16 Dec 2001 07:32:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1899 invoked from network); 16 Dec 2001 07:32:05 -0000
Message-ID: <104801c18603$c811fb10$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
References: <m33d2pam3l.fsf@appel.lilypond.org> <00d501c17d93$1936c990$0200a8c0@lifelesswks> <m3zo4x7obb.fsf@appel.lilypond.org> <m38zcdssxd.fsf@appel.lilypond.org> <01a801c18036$3d447350$0200a8c0@lifelesswks> <m3itbhqowz.fsf@appel.lilypond.org> <027001c18040$c91651f0$0200a8c0@lifelesswks> <m3wuzth3l1.fsf@appel.lilypond.org> <04db01c18302$e66cae60$0200a8c0@lifelesswks> <m3667ax540.fsf@appel.lilypond.org> <20011213215355.GA20040@redhat.com>
Subject: RFP : shell defaults
Date: Mon, 05 Nov 2001 06:46:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 16 Dec 2001 07:32:04.0803 (UTC) FILETIME=[C26CF930:01C18603]
X-SW-Source: 2001-q4/txt/msg00124.txt.bz2


----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>

> I believe that the prompt reflects DJ Delorie's prompt preference,
which
> was, apparently, two lines.
>
> *I'd* prefer no prompt setting at all, actually.  I think that prompt
> setting should be up to the user or the local sysadmin.  AFAICT, even
> Red Hat doesn't try to make a prompt decision for you.

If someone wants to follow my notes in reply to Corinna and create a
shell defaults package, that would be great. AFAIK all distro's generate
a very simply prompt for you, and then leave it up to you.

Setup.exe can leave this aside for the moment (see the other email), and
once a package is in place we can strip out the etc_profile code.

Rob
