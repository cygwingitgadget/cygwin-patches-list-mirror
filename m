Return-Path: <cygwin-patches-return-4230-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17276 invoked by alias); 24 Sep 2003 18:09:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5838 invoked from network); 24 Sep 2003 16:25:01 -0000
Message-ID: <71A0F7B0F1F4F94F85F3D64C4BD0CCFE02BF2478@bmkc1svmail01.am.mfg>
From: "Parker, Ron" <rdparker@butlermfg.com>
To: cygwin-patches@cygwin.com
Subject: Deep directory support
Date: Wed, 24 Sep 2003 18:09:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-SW-Source: 2003-q3/txt/msg00246.txt.bz2

Please read beyond the next paragraph before hitting delete.  Odd file names
are not the issue here, so bare with my for a minute.  I'll get to the point
shortly.

Once upon a time I messed with making changes to Cygwin to allow protected
file names like "aux" to work with Cygwin.  At the time I was looking into
using the UNICODE file functions and prepending '\\?\' to the file's name in
order to accomplish this.  On NT-based systems this basically goes directly
to the device namespace, bypassing a lot of the filtering and limitations of
the Win32 subsystem.  I never submitted this code, because it was ugly,
required touching Cygwin all over the place and I didn't have the time to
implement it cleanly.

However, of late I have been playing with arch (specifically tla) and have
run into an issue with Cygwin.  Namely MAX_PATH is 260 and it is common for
arch repositories to have tar files that are deeper than this.  I have tried
working around these issues in tla, but normalize_posix_path and other areas
of Cygwin that return ENAMETOOLONG keep causing errors in tar when
attempting to extract some of these files.

I am working on some Cygwin patches and would like input and some idea of
whether my idea has an ice cube's chance in hell of being accepted or not.
It basically boils down to doing something like what I originally thought of
for files with protected device names.  At this point my patches arbitrarily
increase MAX_PATH to 4096 and map most of the CreateFile calls to a function
provisionally called createfile.  If is_winnt, this function prepends '\\?\'
to the absolute path name, converts that to UNICODE and calls CreateFileW,
otherwise it just passes through to CreateFile(A).  The 4096 is just to
match Linux, the SDK is not specific on how close to 32Ki you can get before
things blow up, so I am being conservative.

I realize that CreateFile is not the only thing that I will have to deal
with for this to be a complete solution.  I will need to do something
similar for other functions as well, but I wanted some input before creating
an unacceptable solution.  Is this a desirable approach to the issue.

One nasty side-effect of this is that Explorer will blow up drilling down
into a deep directory structure and it gets errors attempting to delete a
deep directory structure.  Both are Explorer bugs, IMO.  The deleting issue
can be worked around in Explorer by moving subdirectories in the deep
structure to  a higher level, say the drive's root directory, and deleting
them from there.

Any thoughts or input?
