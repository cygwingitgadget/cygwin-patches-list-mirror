Return-Path: <cygwin-patches-return-4807-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22732 invoked by alias); 2 Jun 2004 21:24:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22723 invoked from network); 2 Jun 2004 21:24:10 -0000
Date: Wed, 02 Jun 2004 21:24:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: NUL and other special names
Message-ID: <20040602212409.GB7574@coe.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net> <20040601191818.GA30350@coe.casa.cgf.cx> <40BCFF2B.D4FCDF5@phumblet.no-ip.org> <20040601222846.GA19390@coe.casa.cgf.cx> <40BE43B4.4010103@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BE43B4.4010103@att.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00159.txt.bz2

On Wed, Jun 02, 2004 at 05:16:36PM -0400, David Fritz wrote:
>Christopher Faylor wrote:
>>I keep thinking that there is a layer of translation that we're missing
>>here and we should be somehow using an enumeration that the OS provides
>>rather than coming up with our own table.
>
>NtQueryAttributesFile() ??

I suspect that would not provide you with the information you need since
it is probably too low level.

cgf
