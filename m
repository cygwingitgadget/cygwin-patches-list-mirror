Return-Path: <cygwin-patches-return-2416-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8475 invoked by alias); 13 Jun 2002 16:25:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8461 invoked from network); 13 Jun 2002 16:25:07 -0000
Message-ID: <3D08C870.866AECA8@ieee.org>
Date: Thu, 13 Jun 2002 09:25:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin()
References: <3.0.5.32.20020612230833.0080d100@mail.attbi.com> <3.0.5.32.20020612205711.007f7300@mail.attbi.com> <3.0.5.32.20020612205711.007f7300@mail.attbi.com> <3.0.5.32.20020612230833.0080d100@mail.attbi.com> <3.0.5.32.20020612233905.0080d100@mail.attbi.com> <20020613044406.GA15352@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00399.txt.bz2

Christopher Faylor wrote:

> Reexamining what you did in spawn_guts, it looks like there may still be
> a need to call the environment builder in two separate places.  One
> before CreateProcess and one immediately before CreateProcessAsUser.

Thinking aloud (lunch break), still haven't looked at what you did
but inspired by the words "environment builder".

The loop copying the environment inside spawn.cc is really internal
environment stuff that could be handled inside environ.cc in a function
char ** call_chris(char **replace_env, int * ret_size)

This function would return a pointer to a new environment (malloced
inside call_chris), copied from the existing environment, with the
new environment size returned in ret_size. 
replace_env would be an environment built by the user (possibly
with extra info you deem useful, such as string lengths). Any name
present in replace_env would be omitted during the copying if there
is nothing to the right of "=", or would be replaced by what's to
the right of "=".

That function would be called from spawn.cc with a NULL replace_env
in the case of CreateProcess, or with an appropriate Windows env
in the case of CreateProcessAsUser. 

Pierre
