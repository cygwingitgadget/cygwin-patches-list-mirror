Return-Path: <cygwin-patches-return-4712-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9528 invoked by alias); 6 May 2004 09:25:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9489 invoked from network); 6 May 2004 09:25:54 -0000
Date: Thu, 06 May 2004 09:25:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to handle Win32 named pipes as file names
Message-ID: <20040506092553.GU2201@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BAY9-F27kwn9Wgtc2S6000011ec@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY9-F27kwn9Wgtc2S6000011ec@hotmail.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00064.txt.bz2

Stephen,

On May  4 22:36, Stephen Cleary wrote:
> Attached is a patch, ChangeLog, and one new file that allows Cygwin 
> programs to open Win32 named pipe instances (e.g., "\\.\pipe\pipename") 
> through an open() call. The resulting handle will appear like a FIFO to the 
> calling program.

while I really appreciate the effort, that's not what we expect from
an fhandler to do.  Cygwin is a POSIX layer.  An fhandler should at
least try to come up with a POSIX-like translation of a Windows
capability, in this case, converting Windows named pipes into POSIX
FIFOs on the API level.  What your code is doing is just allowing to
use Windows named pipes untranslated and treating them as FIFOs in
stat().

The ability to open/read/write/close WIndows named pipes should already
be available without much of a code change.  Paths like //./pipe/foo
should go through untranslated, just treated like normal files.  If that
doesn't work, feel free to fix the code snippets which accidentally disallow
that.

However, if you want to contribute code to Cygwin, we need a copyright
assignment from you, filled out and snail mailed to Red Hat.  Please
see http://cygwin.com/contrib.html for details.


I hope that's not too discouraging,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
