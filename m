Return-Path: <cygwin-patches-return-4763-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11376 invoked by alias); 15 May 2004 16:12:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11360 invoked from network); 15 May 2004 16:11:59 -0000
Date: Sat, 15 May 2004 16:12:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: ./.. changed during execution of find
Message-ID: <20040515161158.GA21098@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <40A4CB07.93BF544@ieee.org> <3.0.5.32.20040514223818.007fdc80@incoming.verizon.net> <20040515155608.GA25768@coe.bosbc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040515155608.GA25768@coe.bosbc.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00115.txt.bz2

On Sat, May 15, 2004 at 11:56:08AM -0400, Christopher Faylor wrote:
>On Fri, May 14, 2004 at 10:38:18PM -0400, Pierre A. Humblet wrote:
>>I have been rereading the chdir thread to see how things 
>>went wrong. The problem with find is due to the following change
>><http://cygwin.com/ml/cygwin-patches/2004-q2/msg00063.html>
>>
>>> That means that cwd.set always attempts to build the
>>> Posix wd through the mount table.
>>> Up to now that was only the case when a symlink was
>>> involved in the translation, or there was a ":" or a "\" 
>>> in the directory name, or check_case was not relaxed.
>>
>>It follows that "find /" has always been broken when 
>>check_case != "relax". 
>>
>>Please review carefully! In addition to fixing the find bug the
>>patch fixes the handling of paths such as c:xxx and it calls
>>SetCurrentDirectory inside the muto region.
>
>I don't think that would be a problem.  It makes sense to do that
>in fact.
>
>(famous last words)
>
>I've checked this in and am generating a snapshot now.

...which died immediately.  I think you forgot a corresponding cygheap.h
change.  I've checked in the required stuff.

Thanks for fixing this problem.

cgf
