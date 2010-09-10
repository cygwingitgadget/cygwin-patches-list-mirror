Return-Path: <cygwin-patches-return-7089-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12519 invoked by alias); 10 Sep 2010 15:09:00 -0000
Received: (qmail 11796 invoked by uid 22791); 10 Sep 2010 15:08:48 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 10 Sep 2010 15:08:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1630B6D435B; Fri, 10 Sep 2010 17:08:40 +0200 (CEST)
Date: Fri, 10 Sep 2010 15:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
Message-ID: <20100910150840.GD16534@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20100906132409.GB14327@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00049.txt.bz2

On Sep  6 15:24, Corinna Vinschen wrote:
> > - GetVolumeInfo: The C:\ drive does not tend to be changed every
> > millisecond! Therefore no reason for every filesystem syscall to
> > call it. Caching this further increased the performance.
> 
> Does your FS caching take volume mount points into account?

We had some filesystem caching back in Cygwin 1.5 already, but the new
code in symlink_info::check and fs_info::update was supposed to make it
unnecessary.

However, I created a new caching mechanism now, which requires only a
single NtQueryVolumeInformationFile call and then uses the result for a
hash.  I also tested a method which uses the object name of the
underlying NT device as key for the hash, but it's actually ~10% slower
than using the content of the FILE_FS_VOLUME_INFORMATION structure
returned by NtQueryVolumeInformationFile(..., FileFsVolumeInformation).
That's a rather unexpected result, but that's Windows.

> > - File security check: GetSecurityInfo() is implemented in Windows
> > in usermode dll (Advapi32.dll). It calls at the end
> > NtQuerySecurityObject(). So I implemented a faster version:
> > zGetSecurityInfo() which does the same... just faster.
> 
> Does your code preserve the inheritance entries which are available via
> GetSecurityInfo?  Note that I don't care at all for the GetSecurityInfo
> API from a usage POV.  I would prefer to use NtQuerySecurityObject
> directly.  However, the sole reason for using GetSecurityInfo is the
> fact that NtQuerySecurityObject only returns the plain ACL as it's
> stored for the file.  It does not return the ACEs which are inherited
> from the parent objects.  These are only available via GetSecurityInfo,
> or by checking the parent ACLs manually.

This turned out to be total nonsense.  The actual reason to use
GetSecurityInfo was the fact that it's the only function which sets the
INHERITED_ACE flag, as my comment in get_file_sd tells everybody who's
willing to read.  So I read that now, too.

A bit of looking through the code shows that the INHERITED_ACE flag is
*only* required if a file has just been created (see alloc_sd).  So only
the call to set_file_attribute in fhandler_base::open() really needs
these flags.

What I did now was to extend get_file_sd to call GetSecurityInfo only in
this case, while every other call to get_file_sd will actually just call
NtQuerySecurityObject, which is obviously faster because it doesn't have
to check the parent ACL.  Additionally I changed the allocation for the
security_descriptor structure so that it's allocated big enough and only
a single call to NtQuerySecurityObject is performed, rather than two.

Other than that I  have another patch in the loop which stores file
information from symlink_info::check to reuse them in calls to stat,
to drop another OS call.  This needs a bit more testing, though.

All in all the number of OS calls accessing "foo" in a single `ls -l
foo' call has dropped from 18 to 12.  `stat foo' needed 10  before,
now it needs 8 or 7, depending on the fs caching state.  `ls -lR'
on a Samba drive now is almost 30% faster.

What I'm still mulling over is a good idea to re-use the results of a
former call to readdir in a stat call.  One problem here is to make sure
that a subsequent stat call is *really* accessing the same file as the
former readdir returned.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
