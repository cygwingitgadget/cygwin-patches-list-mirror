Return-Path: <cygwin-patches-return-3677-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23486 invoked by alias); 8 Mar 2003 03:37:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23477 invoked from network); 8 Mar 2003 03:37:19 -0000
Date: Sat, 08 Mar 2003 03:37:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: utmp
Message-ID: <20030308033745.GA2743@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030307220508.007d2d50@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030307220508.007d2d50@mail.attbi.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00326.txt.bz2

On Fri, Mar 07, 2003 at 10:05:08PM -0500, Pierre A. Humblet wrote:
>Here is GetComputerName replacing cygwin_gethostname.  When testing I
>found an old bug: ut_id wasn't set although login() uses it in
>getutid(), called from pututline().
>
>utmp is now closed with endutent() (that's what sshd does too) and I
>optimized setutent.
>
>Please review & apply.

Done & done.

Thanks for the patch.

cgf
