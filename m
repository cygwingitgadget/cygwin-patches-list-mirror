Return-Path: <cygwin-patches-return-4500-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4037 invoked by alias); 11 Dec 2003 18:08:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4028 invoked from network); 11 Dec 2003 18:08:00 -0000
Date: Thu, 11 Dec 2003 18:08:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix tcflush hang with streaming devices
Message-ID: <20031211180759.GA21485@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.58.0312101416580.28297@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0312101416580.28297@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00219.txt.bz2

On Dec 10 14:57, Brian Ford wrote:
> 2003-12-10  Brian Ford  <ford@vss.fsi.com>
> 
> 	* fhandler_serial.cc (fhandler_serial::tcflush): Simplify.  Remove
> 	read polling loop to avoid a hang with streaming devices.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
