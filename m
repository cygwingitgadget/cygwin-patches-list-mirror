Return-Path: <cygwin-patches-return-3948-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9292 invoked by alias); 12 Jun 2003 15:22:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7170 invoked from network); 12 Jun 2003 15:21:50 -0000
Date: Thu, 12 Jun 2003 15:22:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Problems on accessing Windows network resources
Message-ID: <20030612152149.GB30116@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030611230336.00807a30@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030611230336.00807a30@mail.attbi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00175.txt.bz2

Hi Pierre,

On Wed, Jun 11, 2003 at 11:03:36PM -0400, Pierre A. Humblet wrote:
> Corinna, 
> 
> Here is the patch to preserve the external token.

Looks good.  I like especially the deimpersonate/reimpersonate methods.

> You will see that cygwin_set_impersonation_token() should
> now return a success/failure indication, instead of void.
> That's not done yet, waiting for your opinion.

How do you intend to use that return value?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
