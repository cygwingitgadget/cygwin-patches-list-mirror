Return-Path: <cygwin-patches-return-5402-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4629 invoked by alias); 30 Mar 2005 23:11:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4561 invoked from network); 30 Mar 2005 23:10:58 -0000
Received: from unknown (HELO CLEMSON.EDU) (130.127.28.87)
  by sourceware.org with SMTP; 30 Mar 2005 23:10:58 -0000
Received: from [130.127.121.232] (130-127-121-232.generic.clemson.edu [130.127.121.232])
	(authenticated bits=0)
	by CLEMSON.EDU (8.13.1/8.13.1) with ESMTP id j2UNArtD022142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2005 18:10:56 -0500 (EST)
Message-ID: <424B31F2.4010508@gawab.com>
Date: Wed, 30 Mar 2005 23:11:00 -0000
From: Nicholas Wourms <nwourms@gawab.com>
Reply-To: cygwin-patches@cygwin.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 MultiZilla/1.7.0.2b (ax) Mnenhy/0.7.2.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: "decorate" gcc extensions with __extension__
References: <20050327065657.21624.qmail@gawab.com> <20050329104322.GB28534@cygbert.vinschen.de> <4249A3F0.6020007@gawab.com> <20050329203032.GB32369@trixie.casa.cgf.cx> <4249E5D0.1000201@gawab.com> <20050330054609.GD2969@trixie.casa.cgf.cx>
In-Reply-To: <20050330054609.GD2969@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Level: x
X-SW-Source: 2005-q1/txt/msg00105.txt.bz2

Christopher Faylor wrote:

> Ok.  Again, I don't want to worry about the use of __extension__.  If I
> am not going to worry about it and Corinna doesn't want to be worrying
> about it then I don't see any reason to do it.  It doesn't make much
> sense to use it if the two principles aren't interested.
> 
> Case closed.

I'm sorry I replied and caused you further irritation, I thought this was still
open to discussion.  Since it isn't, I shall move on.

Before I submit my next patch, I was hoping we might further discuss the use of
"a ?: c", since you mentioned it was a conscious decision.  As I noted
previously, I thought it could be a source of confusion since this behaviour is
not documented and is not widely know.  My supposition was confirmed when even
a seasoned programmer like Gary Van Sickle was not aware of this behavior.  I,
myself, had to rummage through the GCC source code to be absolutely certain
what the implict behavior was.  I propose expanding all such instances to "a ?
a : c" to improve clarity of intent and code readability.  Thanks in advance.

Cheers,
Nicholas
