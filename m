Return-Path: <cygwin-patches-return-4345-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23990 invoked by alias); 6 Nov 2003 17:06:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23981 invoked from network); 6 Nov 2003 17:06:56 -0000
Date: Thu, 06 Nov 2003 17:06:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] : make cygpath use multiple filename arguments
Message-ID: <20031106170655.GA18490@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3FAA7D7F.9080408@fangorn.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAA7D7F.9080408@fangorn.ca>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00064.txt.bz2

On Thu, Nov 06, 2003 at 11:57:35AM -0500, Mark Blackburn wrote:
>This patch will allow you to do this.
>
>$ ./cygpath.exe -w -a cygpath.cc cygpath.exe
>E:\cygwin\usr\src\cygwin-cvs\src\winsup\utils\cygpath.cc
>E:\cygwin\usr\src\cygwin-cvs\src\winsup\utils\cygpath.exe
>
>I don't know if this is desired behaviour or not. Personally, I would
>find it useful.

Any objections to this patch?  I don't think it is the first time it's
been suggested.

cgf
