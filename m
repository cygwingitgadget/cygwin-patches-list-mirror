Return-Path: <cygwin-patches-return-7161-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13671 invoked by alias); 1 Feb 2011 17:08:22 -0000
Received: (qmail 13513 invoked by uid 22791); 1 Feb 2011 17:07:57 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 01 Feb 2011 17:07:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 31F3E2C0328; Tue,  1 Feb 2011 18:07:46 +0100 (CET)
Date: Tue, 01 Feb 2011 17:08:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix bogus fsync() error
Message-ID: <20110201170746.GA15066@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D471106.4050304@t-online.de> <20110201084715.GM1057@calimero.vinschen.de> <20110201154818.GA14218@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110201154818.GA14218@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00016.txt.bz2

On Feb  1 10:48, Christopher Faylor wrote:
> On Tue, Feb 01, 2011 at 09:47:15AM +0100, Corinna Vinschen wrote:
> >On Jan 31 20:44, Christian Franke wrote:
> >> If used on raw devices like /dev/sda fsync() always fails with
> >> EBADRQC (54) because FlushFileBuffers() always fails with
> >> ERROR_INVALID_FUNCTION (1).
> >> 
> >> The attached patch fixes this by simply ignoring this error in the
> >> fhandler_base implementation. This should not affect any real flush
> >> errors which likely would return other error codes.
> >> 
> >> An alternative approach would be to ignore the error only in a new
> >> fhandler_raw_dev/floppy::fsync(). IMO not worth the effort is this
> >> case.
> >
> >I agree.  I applied the patch.
> 
> Shouldn't this patch be a little more robust and check that you're getting
> ERROR_INVALID_FUNCTION only for raw devices?

Filesystems should never return this error code, afaik.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
