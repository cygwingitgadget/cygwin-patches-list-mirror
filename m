Return-Path: <cygwin-patches-return-3305-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25346 invoked by alias); 11 Dec 2002 19:20:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25336 invoked from network); 11 Dec 2002 19:20:56 -0000
Date: Wed, 11 Dec 2002 11:20:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Small security patches
Message-ID: <20021211192211.GD29798@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DF76981.86674258@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF76981.86674258@ieee.org>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00256.txt.bz2

On Wed, Dec 11, 2002 at 11:36:17AM -0500, Pierre A. Humblet wrote:
>Corinna,
>
>here is an internationalization bug fix, and some preliminary
>definitions for a future well_known_creator approach.
>
>Pierre
>
>2002/12/11  Pierre Humblet  <pierre.humblet@ieee.org>
>
>	* security.h: Declare well_known_creator_group_sid.
>	* sec_helper.cc: Declare and initialize well_known_creator_group_sid.
>	* security.cc (get_user_local_groups): Use LookupAccountSid to find the
>	local equivalent of BUILTIN.

Shouldn't the global symbols be marked as "NO_COPY"?

cgf
