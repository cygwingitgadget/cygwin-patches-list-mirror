Return-Path: <cygwin-patches-return-2851-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31840 invoked by alias); 21 Aug 2002 19:56:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31825 invoked from network); 21 Aug 2002 19:56:21 -0000
Date: Wed, 21 Aug 2002 12:56:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: recv/send revert patch
Message-ID: <20020821195621.GB30141@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <017501c24948$aa02fa30$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017501c24948$aa02fa30$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00299.txt.bz2

On Wed, Aug 21, 2002 at 08:26:35PM +0100, Conrad Scott wrote:
>Attached is a patch to revert the recv/send patch I submitted a
>couple of weeks ago.  This doesn't revert the whole patch, just
>those parts related to using recvfrom/sendto calls to implement
>recv/send.

Would it make sense to use recvfrom/sendto on systems that support
it by implementing a new wincap capability?

cgf
