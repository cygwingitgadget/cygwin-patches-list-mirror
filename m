Return-Path: <cygwin-patches-return-4820-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27458 invoked by alias); 3 Jun 2004 21:52:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27441 invoked from network); 3 Jun 2004 21:52:38 -0000
Message-ID: <40BF9DA3.FA6D1B0F@phumblet.no-ip.org>
Date: Thu, 03 Jun 2004 21:52:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: David Fritz <zeroxdf@att.net>
CC: cygwin-patches@cygwin.com
Subject: Re: [Patch]: NUL and other special names
References: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net> <40BF81C4.1020105@att.net> <40BF870A.B42E5C3E@phumblet.no-ip.org> <40BF9225.8040100@att.net> <40BF9A29.80408@att.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00172.txt.bz2



David Fritz wrote:
> 
> I don't think the logic implemented by RtlIsDosDeviceName_U() is all that
> different from the logic in the patch.  Which is to say, it seems to use a
> hard-coded list of names and does not actually check for existing devices.  Do
> we want to block all names that could be DOS devices or just the names of
> devices that exist?

We must handle all DOS devices because the behaviors of NtCreateFile
and of the file related Windows calls differ for those names.

When you say "block", do you take position on what we should do
(block, emulate Windows, emulate Posix)?

> This is interesting:
> 
> http://msdn.microsoft.com/library/en-us/fileio/base/querydosdevice.asp

Yes

> So is this:
> 
> -----
> C:\>ver
> 
> Windows 98 [Version 4.10.2222]
> 
> C:\>type config$
> 
> Invalid device request reading device CONFIG$
> Abort, Retry, Ignore, Fail?f
> Fail on INT 24 - config$
> -----

Right, and this (on Win98)

W:~: touch config$.123
W:~: ls -l config$.123
ls: config$.123: No such file or directory
W:~: touch config$.1234
W:~: ls -l config$.1234
-rw-r--r--    1 pierre   all             0 Jun  3 17:46 config$.1234

On NT config$ is OK, but con.1234 isn't.
Experimenting with Windows is mind boggling.

Pierre
