Return-Path: <cygwin-patches-return-2577-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14535 invoked by alias); 2 Jul 2002 03:23:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14521 invoked from network); 2 Jul 2002 03:23:05 -0000
Date: Mon, 01 Jul 2002 20:23:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Any ideas with xterm/xfree problem?
Message-ID: <20020702032313.GA1615@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020701204140.GA25217@redhat.com> <3D20C1DA.26509E01@ieee.org> <20020701212139.GE25306@redhat.com> <3.0.5.32.20020701225143.00820590@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020701225143.00820590@mail.attbi.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00025.txt.bz2

On Mon, Jul 01, 2002 at 10:51:43PM -0400, Pierre A. Humblet wrote:
>Chris,
>
>Here is a better patch taking care of both uid and gid.
>It was tested against the situations created by Harold
>for xterm. AFAIK proper passwd/group are needed for ssh.
>
>The goal is to allow seteuid/gid to itself even when passwd
>and/or group are not properly setup.
>Please revert the previous one.

Ok.  The old one is reverted and the new one is applied.  A new snapshot
is building now.

cgf
