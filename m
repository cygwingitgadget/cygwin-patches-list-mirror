Return-Path: <cygwin-patches-return-3319-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29177 invoked by alias); 14 Dec 2002 19:40:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29098 invoked from network); 14 Dec 2002 19:40:20 -0000
Date: Sat, 14 Dec 2002 11:40:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] termios accept_input
Message-ID: <20021214194145.GA2089@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021210002215.A15522@fnord.io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021210002215.A15522@fnord.io.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00270.txt.bz2

On Tue, Dec 10, 2002 at 12:22:15AM -0600, Steve O wrote:
>ChangeLog
>2002-12-09  Steve Osborn  <bub@io.com>
>
>	* fhandler_termios.cc (fhandler_termios::line_edit): Call
>	accept_input() in character processing loop.  Set return 
>	value independently of input_done.

Applied.  Thanks.

cgf
