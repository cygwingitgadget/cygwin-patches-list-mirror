Return-Path: <cygwin-patches-return-5436-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27974 invoked by alias); 6 May 2005 23:41:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27946 invoked from network); 6 May 2005 23:41:52 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 6 May 2005 23:41:52 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 0BA5313C752; Fri,  6 May 2005 19:41:52 -0400 (EDT)
Date: Fri, 06 May 2005 23:41:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: mkdir -p and network drives
Message-ID: <20050506234151.GM29240@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <427BEFD2.7080809@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427BEFD2.7080809@byu.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00032.txt.bz2

On Fri, May 06, 2005 at 04:29:38PM -0600, Eric Blake wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>>I thought that Eric Blake implied that // *had* to be translated to /,
>>as per POSIX.  I wonder how many programs out there translate a
>>standalone '//' to '/'.
>
>No, POSIX requires that / be untouched, // be implementation-defined
>(hint - - define it on cygwin to stay untouched), and /// translate to
>/.

Ok.  I knew that but I misinterpreted something you said as implying
that '//' was not implementation defined.  This was just a misreading
on my part, though.

cgf
