Return-Path: <cygwin-patches-return-3408-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1211 invoked by alias); 15 Jan 2003 20:30:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1174 invoked from network); 15 Jan 2003 20:30:37 -0000
Date: Wed, 15 Jan 2003 20:30:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: Charles Wilson <cwilson@ece.gatech.edu>
Cc: cygwin-patches@cygwin.com
Subject: Re: Where to put my basename() and dirname() implementation...
Message-ID: <20030115203137.GK23351@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Charles Wilson <cwilson@ece.gatech.edu>,
	cygwin-patches@cygwin.com
References: <59A835EDCDDBEB46BC75402F4604D5528F75D6@elmer> <009201c2bcc0$82411040$305886d9@webdev> <20030115183034.GH15975@redhat.com> <3E25C2DB.7060808@ece.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E25C2DB.7060808@ece.gatech.edu>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00057.txt.bz2

On Wed, Jan 15, 2003 at 03:21:47PM -0500, Charles Wilson wrote:
>Christopher Faylor wrote:
>
>>
>>I don't want to add any more libiberty routines to cygwin since the
>>licensing is suspect.  So, please follow the normal submission rules.
>>Probably miscfuncs.cc is the place to add this.
>>
>
>That make sense.  Unlike many of the other functions in libiberty, The 
>basename() function itself in libiberty/basename.c is public domain -- 
>which may be good for our purposes, or it may be bad (I dunno, and cgf 
>has already made the call: it's "suspect". Fair enough.)  In any case, 
>it does no harm to have "our" own version that can be copyright-assigned 
>to Red Hat and distributed under the Cygwin license.

I once thought that the libiberty functions were ok to use but someone
told me that their copyright status was suspect.  Perhaps more
pragmatically, I don't like the current method of depending on libiberty
objects in the makefile.

So, I think it's simpler to avoid using them.

However, pulling in versions from, say, FreeBSD would be acceptable.

cgf
