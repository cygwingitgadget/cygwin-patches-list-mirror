Return-Path: <cygwin-patches-return-2709-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15045 invoked by alias); 24 Jul 2002 15:31:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15031 invoked from network); 24 Jul 2002 15:31:21 -0000
Date: Wed, 24 Jul 2002 08:31:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: src/winsup/cygwin ChangeLog cygwin.din
Message-ID: <20020724153129.GE13558@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020724073803.17255.qmail@sources.redhat.com> <145518762130.20020724122337@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145518762130.20020724122337@logos-m.ru>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00157.txt.bz2

On Wed, Jul 24, 2002 at 12:23:37PM +0400, egor duda wrote:
>Wednesday, 24 July, 2002 corinna@cygwin.com corinna@cygwin.com wrote:
>
>ccc> CVSROOT:        /cvs/src
>ccc> Module name:    src
>ccc> Changes by:     corinna@sources.redhat.com      2002-07-24 00:38:03
>
>ccc> Modified files:
>ccc>         winsup/cygwin  : ChangeLog cygwin.din 
>
>ccc> Log message:
>ccc>         * cygwin.din (fcloseall): Add symbol for export.
>ccc>         (fcloseall_r): Ditto.
>
>How about this? The check is not a panacea, but at least it catches
>most typical cases.
>
>2002-07-24  Egor Duda  <deo@logos-m.ru>
>
>        * Makefile.in: Check if API version is updated when exports
>        from dll are changed and stop if not so.
>        * include/cygwin/version.h: Bump minor API version.

Great idea, Egor.  Please check it in.

Hmm.  I wonder if we could automatically generate the version number
when cygwin.din changes.

cgf
