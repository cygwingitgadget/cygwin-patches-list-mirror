Return-Path: <cygwin-patches-return-2367-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29787 invoked by alias); 8 Jun 2002 01:39:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29772 invoked from network); 8 Jun 2002 01:39:05 -0000
Date: Fri, 07 Jun 2002 18:39:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for epoch in hires_ms::usecs() value
Message-ID: <20020608013923.GA24649@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <008801c20e67$4850f240$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008801c20e67$4850f240$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00350.txt.bz2

On Fri, Jun 07, 2002 at 10:07:06PM +0100, Conrad Scott wrote:
>2002-06-07  Conrad Scott  <conrad.scott@dsl.pipex.com>
>
>	* times.cc (hires_ms::prime): Adjust epoch of initime_us from 1601
>	to 1970.

Applied, thanks.

cgf
