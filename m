Return-Path: <cygwin-patches-return-2665-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8243 invoked by alias); 19 Jul 2002 08:23:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8226 invoked from network); 19 Jul 2002 08:23:31 -0000
Date: Fri, 19 Jul 2002 01:23:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Corinna or Pierre please comment? [jason@tishler.net: Re: setuid
Message-ID: <20020719102328.E6932@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020718211250.0080a5e0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020718211250.0080a5e0@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00113.txt.bz2

On Thu, Jul 18, 2002 at 09:12:50PM -0400, Pierre A. Humblet wrote:
> Corinna,
> 
> Here is the patch.

Thanks but I don't see why you removed the call to get_user_primary_group().
You now rely fully on /etc/passwd and /etc/group containing the correct
information.  Before, prgpsid has been set to a value if it was NULL, now
it's only used for checking.  This would result in

  pgrp.PrimaryGroup = NULL;

in the calling create_token() function.  Which probably results in
a failing NtCreateToken() function.


Another question.  Shouldn't this in create_token

      psa = __sec_user (sa_buf, usersid, TRUE);
      if (psa->lpSecurityDescriptor &&
          !SetSecurityDescriptorGroup (
              (PSECURITY_DESCRIPTOR) psa->lpSecurityDescriptor,
              special_pgrp ? pgrpsid : well_known_null_sid, FALSE))
              ^^^^^^^^^^^^

better be change to

      psa = __sec_user (sa_buf, usersid, TRUE);
      if (psa->lpSecurityDescriptor &&
          !SetSecurityDescriptorGroup (
              (PSECURITY_DESCRIPTOR) psa->lpSecurityDescriptor,
              pgrpsid ? pgrpsid : well_known_null_sid, FALSE))
              ^^^^^^^

?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
