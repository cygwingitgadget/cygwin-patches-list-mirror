Return-Path: <cygwin-patches-return-4900-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5297 invoked by alias); 17 Aug 2004 09:54:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5150 invoked from network); 17 Aug 2004 09:54:08 -0000
Date: Tue, 17 Aug 2004 09:54:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [Patch]: fhandler_dsp.cc
Message-ID: <20040817095430.GG1689@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <01C4821C.DCA0AFF0.Gerd.Spalink@t-online.de> <3.0.5.32.20040816230400.00810670@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040816230400.00810670@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00052.txt.bz2

On Aug 16 23:04, Pierre A. Humblet wrote:
> Following Gerd's comments, here is an updated patch that also improves 
> the internal error handling. It follows Gerd's approach.
> 
> He has not answered my previous e-mail but he has indicated he would
> be in vacation for two weeks, so this is not unexpected.
>  
> I have also verified that the code passes Gerd's new nasty dup test.
> I think we are good to go for now.

Tested and applied.

Thanks to both of you, Pierre for the patch and Gerd for his valuable
input and the changed testsuite test.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
