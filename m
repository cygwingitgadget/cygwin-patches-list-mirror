Return-Path: <cygwin-patches-return-6174-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19434 invoked by alias); 22 Nov 2007 17:01:14 -0000
Received: (qmail 19401 invoked by uid 22791); 22 Nov 2007 17:01:03 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-70-20-17-24.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (70.20.17.24)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 22 Nov 2007 17:00:53 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id A893D2B352; Thu, 22 Nov 2007 12:00:51 -0500 (EST)
Date: Thu, 22 Nov 2007 17:01:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Resource Temporarily Unavailable workaround
Message-ID: <20071122170051.GA29996@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4745B152.3070704@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4745B152.3070704@st.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00026.txt.bz2

On Thu, Nov 22, 2007 at 04:41:54PM +0000, Andrew STUBBS wrote:
>The attached patch adds a 'retry' to the fork system call.  Basically
>it waits 10 seconds to allow the 'resource temporarily unavailable' to
>become (temporarily) available once more, and tries again, up to a
>maximum of three attempts.

There is already a retry in the fork and spawn system calls.  This
technique has proved to be problematic since it can mask problems and
you can end up with situations where a process starts successfully but
cygwin thinks it fails and restarts the process again.  For the exec
case, there is also a problem with non-cygwin .exes.

If you look for retry in the fork call you should see where this is
supposed to be happening.

cgf
