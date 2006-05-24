Return-Path: <cygwin-patches-return-5871-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26601 invoked by alias); 24 May 2006 02:28:55 -0000
Received: (qmail 26581 invoked by uid 22791); 24 May 2006 02:28:54 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.180)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 24 May 2006 02:28:52 +0000
Received: by py-out-1112.google.com with SMTP id o67so2012856pye         for <cygwin-patches@cygwin.com>; Tue, 23 May 2006 19:28:51 -0700 (PDT)
Received: by 10.35.60.15 with SMTP id n15mr1750982pyk;         Tue, 23 May 2006 19:28:51 -0700 (PDT)
Received: by 10.35.30.7 with HTTP; Tue, 23 May 2006 19:28:51 -0700 (PDT)
Message-ID: <ba40711f0605231928hb15b1b2s35a9dfde87092f2a@mail.gmail.com>
Date: Wed, 24 May 2006 02:28:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: select.cc exitsock error cleanup
In-Reply-To: <20060524005539.GA14893@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <ba40711f0605231704u29b8860ayd6d30fab02602c70@mail.gmail.com> 	 <20060524005539.GA14893@trixie.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00059.txt.bz2

On 5/23/06, Christopher Faylor wrote:
> I've checked in a variation of this patch but I've used si->exitsock
> for consistency.

I'm sure that's wrong. With your version, the next time select() is
called, the thread-local socket will still look like a valid socket,
even though it has been closed and can't be used. Thus, no further
select()ing may be done on sockets from that thread.

Hmm. Also, the proper error return value appears to be 0, not -1.

So try this version. (I kept si->exitsock in there for good measure --
maybe it'll help someone stepping through with a debugger one day,
etc).

2006-05-23  Lev Bishop  <lev.bishop+cygwin@gmail.com>

	* select.cc (start_thread_socket): Really clean up exitsock in
	case of error. Return correct error return value.
