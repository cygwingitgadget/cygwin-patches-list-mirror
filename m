Return-Path: <cygwin-patches-return-3688-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20410 invoked by alias); 11 Mar 2003 14:40:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20400 invoked from network); 11 Mar 2003 14:40:51 -0000
Message-ID: <3E6DF617.CA7DC2C0@ieee.org>
Date: Tue, 11 Mar 2003 14:40:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: fhandler_socket::dup
References: <3.0.5.32.20030310200902.007f3100@mail.attbi.com> <20030311102431.GB13544@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00337.txt.bz2

Corinna Vinschen wrote:
>
> I'm seriously concidering to remove all the fixup_before/fixup_after
> from fhandler_socket::dup() and just call fhandler_base::dup() on
> NT systems.
 
Corinna,

Isn't that just what you do now?
Just out of curiosity, why hasn't this always been done? I blindly thought
it couldn't but I have just looked up MSDN and there is no mention of any 
restriction of DuplicateHandle with sockets, on any platform. 
Googling didn't enlighten me either.

Pierre
