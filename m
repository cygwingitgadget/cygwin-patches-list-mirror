Return-Path: <cygwin-patches-return-5397-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20941 invoked by alias); 30 Mar 2005 05:46:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20773 invoked from network); 30 Mar 2005 05:46:09 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 30 Mar 2005 05:46:09 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 1991E13C84F; Wed, 30 Mar 2005 00:46:09 -0500 (EST)
Date: Wed, 30 Mar 2005 05:46:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: "decorate" gcc extensions with __extension__
Message-ID: <20050330054609.GD2969@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050327065657.21624.qmail@gawab.com> <20050329104322.GB28534@cygbert.vinschen.de> <4249A3F0.6020007@gawab.com> <20050329203032.GB32369@trixie.casa.cgf.cx> <4249E5D0.1000201@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4249E5D0.1000201@gawab.com>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q1/txt/msg00100.txt.bz2

On Tue, Mar 29, 2005 at 06:33:36PM -0500, Nicholas Wourms wrote:
>Christopher Faylor wrote:
>> However, if I am correctly interpreting your intent, it sounds like you
>> are saying that no one but you would have to worry about sprinkling
>> __extension__'s throughout the code and that we could just write code as
>> we always do.
>
>Again, I'm not suggesting I be the "point man" on this.  Like other
>__attribute__ tags, they can be added as needed/noticed.  It's rather trivial
>and I don't see the implied expenditure of labor involved.  You can add them or
>not, it won't change the way the code is compiled.  Just think of it like
>Rusty's Janitorial patches on LKML.

Ok.  Again, I don't want to worry about the use of __extension__.  If I
am not going to worry about it and Corinna doesn't want to be worrying
about it then I don't see any reason to do it.  It doesn't make much
sense to use it if the two principles aren't interested.

Case closed.

cgf
