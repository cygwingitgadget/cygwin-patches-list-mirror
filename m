Return-Path: <cygwin-patches-return-4604-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31887 invoked by alias); 12 Mar 2004 16:40:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31877 invoked from network); 12 Mar 2004 16:40:04 -0000
Date: Fri, 12 Mar 2004 16:40:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] src/winsup/mingw/include/process.h __STRICT_ANSI__
Message-ID: <20040312164002.GA22086@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <VA.00000f1a.01b89c9b@thesoftwaresource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VA.00000f1a.01b89c9b@thesoftwaresource.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00094.txt.bz2

On Thu, Mar 11, 2004 at 07:23:37PM -0500, Brian Keener wrote:
>I notice when trying to compile the #endif got left behind.  Sure you found it by 
>now.
>
>2004-03-11  Brian Keener  <bkeener@thesoftwaresource.com>
>
>        * include/process.h:  Remove the #endif associated with removal of
>        __STRICT_ANSI__ guard from non-ANSI header.

I've taken the libiberty of applying this patch since it is stalling my
ability to generate a snapshot.

I hope Danny won't mind.

cgf
