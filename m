Return-Path: <cygwin-patches-return-7102-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12305 invoked by alias); 12 Sep 2010 11:41:34 -0000
Received: (qmail 12258 invoked by uid 22791); 12 Sep 2010 11:41:23 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sun, 12 Sep 2010 11:41:18 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1D4856D435B; Sun, 12 Sep 2010 13:41:15 +0200 (CEST)
Date: Sun, 12 Sep 2010 11:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
Message-ID: <20100912114115.GA1113@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de> <20100910150840.GD16534@calimero.vinschen.de> <20100910172312.GA23015@ednor.casa.cgf.cx> <20100910183940.GA14132@calimero.vinschen.de> <4C8C9408.3060304@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4C8C9408.3060304@gmail.com>
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
X-SW-Source: 2010-q3/txt/msg00062.txt.bz2

On Sep 12 10:49, Yoni Londner wrote:
> Hi,
> 
> The caching-speed up is trivial:
> We store the the FileFullDirectoryInformation fields, and if any of
> them change - we re-read the file.
> 
> Its not (in practical life) possible to change a file without
> causing a modification on FileIndex/CreationTime/LastWriteTime/ChangeTime/EndOfFile/AllocationSize/FileAttributes/FileName/EaSize!
> 
> From the MSDN we see the info we can get on a
> FileFullDirectoryInformation request:

We're already using FileBothDirectoryInformation and
FileBothIdDirectoryInformation in readdir anyway.

However, isn't that kind of a chicken/egg situation?  If you want to
reuse the content of the FILE_BOTH{_ID}_DIRECTORY_INFORMATION structure
from a previous call to readdir, you would have to call the
corresponding NtQueryInformationFile call(s) to fetch the information
from the file for comparision purposes.  When you fetched it anyway,
there's no reason anymore to compare them, since you can use what
you just fetched.  Where's the advantage?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
