Return-Path: <cygwin-patches-return-3488-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15931 invoked by alias); 4 Feb 2003 14:58:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15918 invoked from network); 4 Feb 2003 14:58:30 -0000
Date: Tue, 04 Feb 2003 14:58:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: class cygpsid
Message-ID: <20030204145827.GB5822@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030203130845.007fca80@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030203130845.007fca80@mail.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00137.txt.bz2

On Mon, Feb 03, 2003 at 01:08:45PM -0500, Pierre A. Humblet wrote:
> 2003/02/03  Pierre Humblet  <pierre.humblet@ieee.org>
> 
> 	* security.h (class cygpsid): New class.
> 	(class cygsid): Use cygpsid as base. Remove members psid, get_id, 
> 	get_uid, get_gid, string, debug_printf and the == and != operators.
> 	(cygsidlist::clear_supp): Only do work if setgroups has been called.
> 	* sec_helper.cc: Define sid_auth NO_COPY. 
> 	(cygpsid::operator==): New operator.
> 	(cygpsid::get_id): New function.
> 	(cygpsid::string): New function.
> 	(cygsid::string): Delete.
> 	(cygsid::get_id): Delete.
> 	* pwdgrp.h: Change arguments of internal_getpwsid,
> 	internal_getgrsid and internal_getgroups to cygpsid.
> 	* passwd.cc (internal_getpwsid): Change argument from cygsid to cygpsid.
> 	* grp.cc (internal_getgrsid): Ditto.
> 	(internal_getgroups): Ditto.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
