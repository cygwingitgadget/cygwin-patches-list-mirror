Return-Path: <cygwin-patches-return-4799-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6050 invoked by alias); 1 Jun 2004 21:06:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5989 invoked from network); 1 Jun 2004 21:06:13 -0000
Date: Tue, 01 Jun 2004 21:06:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: NUL and other special names
Message-ID: <20040601191818.GA30350@coe.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
Resent-From: Christopher Faylor <cgf@alum.bu.edu>
Resent-Date: Tue, 1 Jun 2004 17:06:13 -0400
Resent-To: cygwin-patches@cygwin.com
Resent-Message-Id: <20040601210613.0AE47400106@cgf.cx>
X-SW-Source: 2004-q2/txt/msg00151.txt.bz2

On Mon, May 31, 2004 at 06:46:11PM -0400, Pierre A. Humblet wrote:
>This patch prevents NtCreateFile from creating files with special
>names such as NUL.
>Because this needs to be checked very often, I tried to code it
>efficiently with a binary search (it can perhaps be reused elsewhere). 
>
>The new function is_special_name() overlaps with special_name(),
>although there are small differences (it was designed from tests
>on XP Home Ed). Perhaps these two can be merged one day.

Haven't we already done a "GetFileAttributes" on the path by the time
it reaches the NtCreateFile?  If so, couldn't we just avoid trying to
create a file which has "bad" attributes?

cgf
