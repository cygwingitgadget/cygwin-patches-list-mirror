Return-Path: <cygwin-patches-return-7108-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28346 invoked by alias); 14 Sep 2010 10:06:23 -0000
Received: (qmail 28311 invoked by uid 22791); 14 Sep 2010 10:06:12 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 14 Sep 2010 10:05:36 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9AC426D435B; Tue, 14 Sep 2010 12:05:33 +0200 (CEST)
Date: Tue, 14 Sep 2010 10:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
Message-ID: <20100914100533.GC15121@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de> <20100910150840.GD16534@calimero.vinschen.de> <20100910172312.GA23015@ednor.casa.cgf.cx> <20100910183940.GA14132@calimero.vinschen.de> <4C8C9408.3060304@gmail.com> <20100912114115.GA1113@calimero.vinschen.de> <4C8E0AC7.9080409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4C8E0AC7.9080409@gmail.com>
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
X-SW-Source: 2010-q3/txt/msg00068.txt.bz2

On Sep 13 13:28, Yoni Londner wrote:
> Hi,
> 
> > However, isn't that kind of a chicken/egg situation?  If you want to
> > reuse the content of the FILE_BOTH{_ID}_DIRECTORY_INFORMATION structure
> > from a previous call to readdir, you would have to call the
> 
> I am not talking about reusing info from a previous readdir.
> 
> Every single file cygwin tries to access, it does it in a loop,
> trying afterwards to check for *.lnk file.
> 
> Using the directory query operations, it is possible to get this
> info faster:
> instead of getting file info for FOO and then for "FOO.lnk",
> Cygwin can query the directory info for "FOO FOO.LNK" (for the file
> requested, plus its possible symlink file).

I don't understand how you think this should work.  The filter expression
given to NtQueryDirectoryFile is either a constant string and has to match
the filename exactly, or it contains wildcards.  This is documented
behaviour: http://msdn.microsoft.com/en-us/library/ff567047%28VS.85%29.aspx
So, "foo" works, "foo*" works, but a list like "foo foo.exe foo.lnk" 
does not.

There's also the problem of handling NFS shares.  However, I just had an
idea how to speed up symlink_info::check without neglecting NFS shares.
This will take some time, though since it turns a lot of code upside
down.  Stay tuned.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
