Return-Path: <cygwin-patches-return-2915-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13260 invoked by alias); 2 Sep 2002 13:54:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13221 invoked from network); 2 Sep 2002 13:53:46 -0000
Date: Mon, 02 Sep 2002 06:54:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: very small passwd patch
Message-ID: <20020902155312.Q12899@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.44.0209020825510.1164-200000@joshua.iocc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.44.0209020825510.1164-200000@joshua.iocc.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00363.txt.bz2

On Mon, Sep 02, 2002 at 08:28:07AM -0500, Joshua Daniel Franklin wrote:
> I thought there was some mention of this already, but I guess
> not. This adds a note about passwd not working with Win9x/ME.

Good idea but it doesn't help.  Since passwd is linked statically
against a symbol only available in NT, a 9x/Me user will never see
this help.  The system dialog will always win the race.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
