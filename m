Return-Path: <cygwin-patches-return-3589-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15906 invoked by alias); 18 Feb 2003 22:59:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15896 invoked from network); 18 Feb 2003 22:59:23 -0000
From: "Gary R Van Sickle" <tiberius@braemarinc.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: Create new files as sparse on NT systems. (2nd try)
Date: Tue, 18 Feb 2003 22:59:00 -0000
Message-ID: <001701c2d7a1$a101a020$2101a8c0@BRAEMARINC.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20030218222803.GA2679@redhat.com>
X-SW-Source: 2003-q1/txt/msg00238.txt.bz2

[snip]

> >What kind of program would actually benefit from sparse
> files? And shouldn't
> >it be the responsibility of that program to request them?
>
> IIRC, linux creates sparse files automatically when you do an lseek to
> a position beyond EOF.  I believe that Windows is similar.
>

No, Windows does nothing like that.  On Windows, sparse files are completely
non-automatic:

"Note: It is up to the application to maintain sparseness by writing zeros
with FSCTL_SET_ZERO_DATA", sez the Platform docs.

Even if you do WriteFile()s with all zeros on a sparse file, you are
actually hitting the disk.

> I would like to see a benchmark but I doubt there will be any
> noticeable
> difference.

The only thing this patch will do AFAICS is set a bit somewhere in the guts
of NTFS that will be pretty much ignored.  I'm with Max, I don't see the
benefit and can only imagine the consequences.

--
Gary R. Van Sickle
Braemar Inc.
11481 Rupp Dr.
Burnsville, MN 55337
