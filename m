Return-Path: <cygwin-patches-return-3485-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11278 invoked by alias); 3 Feb 2003 15:55:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11269 invoked from network); 3 Feb 2003 15:55:40 -0000
Date: Mon, 03 Feb 2003 15:55:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: set_process_privilege and chown
Message-ID: <20030203155538.GB21956@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030203100325.008056f0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030203100325.008056f0@mail.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00134.txt.bz2

On Mon, Feb 03, 2003 at 10:03:25AM -0500, Pierre A. Humblet wrote:
> Corinna,
> 
> Here is a chown related patch, fixing one old and one recent bug.
> 
> 2003/02/03  Pierre Humblet  <pierre.humblet@ieee.org>
> 
> 	* security.h: Add third argument to set_process_privilege.
> 	* autoload.cc: Add OpenThreadToken.
> 	* sec_helper.cc (set_process_privilege): Add and use use_thread argument.
> 	* security.cc (alloc_sd): Modify call to set_process_privilege. Remember
> 	the result in each process. If failed and file owner is not the user, fail.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
