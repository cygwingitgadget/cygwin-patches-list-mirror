Return-Path: <cygwin-patches-return-4014-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24807 invoked by alias); 15 Jul 2003 16:12:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24779 invoked from network); 15 Jul 2003 16:12:20 -0000
Date: Tue, 15 Jul 2003 16:12:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Problems on accessing Windows network resources
Message-ID: <20030715161218.GM12368@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030712093737.00812900@incoming.verizon.net> <3.0.5.32.20030711200253.00807190@mail.attbi.com> <3.0.5.32.20030711200253.00807190@mail.attbi.com> <3.0.5.32.20030712093737.00812900@incoming.verizon.net> <3.0.5.32.20030714232518.00808560@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030714232518.00808560@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00030.txt.bz2

On Mon, Jul 14, 2003 at 11:25:18PM -0400, Pierre A. Humblet wrote:
> Corinna,
> 
> As announced, this patch is only about style conformance and 
> efficiency. You have already applied the bug fix part.
> 
> Pierre
> 
> 2003-07-15  Pierre Humblet  <pierre.humblet@ieee.org>
> 
> 	* security.cc (verify_token): Fix white space and style.
> 	Use type bool instead of BOOL and char. Use alloca
> 	instead of malloc and free for my_grps. 

Please apply.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
