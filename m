Return-Path: <cygwin-patches-return-2418-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17019 invoked by alias); 13 Jun 2002 17:22:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16981 invoked from network); 13 Jun 2002 17:22:02 -0000
Date: Thu, 13 Jun 2002 10:22:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin()
Message-ID: <20020613172230.GB26261@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020612230833.0080d100@mail.attbi.com> <3.0.5.32.20020612205711.007f7300@mail.attbi.com> <3.0.5.32.20020612205711.007f7300@mail.attbi.com> <3.0.5.32.20020612230833.0080d100@mail.attbi.com> <3.0.5.32.20020612233905.0080d100@mail.attbi.com> <20020613044406.GA15352@redhat.com> <3D08C870.866AECA8@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D08C870.866AECA8@ieee.org>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00401.txt.bz2

On Thu, Jun 13, 2002 at 12:29:36PM -0400, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>
>> Reexamining what you did in spawn_guts, it looks like there may still be
>> a need to call the environment builder in two separate places.  One
>> before CreateProcess and one immediately before CreateProcessAsUser.
>
>Thinking aloud (lunch break), still haven't looked at what you did
>but inspired by the words "environment builder".
>
>The loop copying the environment inside spawn.cc is really internal
>environment stuff that could be handled inside environ.cc in a function
>char ** call_chris(char **replace_env, int * ret_size)

Er.  Um.

cgf
