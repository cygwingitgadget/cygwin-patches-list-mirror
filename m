From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: [PATCH]: winnt.h
Date: Wed, 16 May 2001 09:26:00 -0000
Message-id: <20010516182545.F31266@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00251.html

Hi,

I have just applied the following patch to winnt.h:

- Add defines for group attributes SE_GROUP_xxx which are used
  in TOKEN_GROUPS as groups attributes in the LUID_AND_ATTRIBUTES
  structure.

- Add define for SYSTEM_LUID which is a predefined logon session
  used in some authentication related calls.

- Add missing types PTOKEN_DEFAULT_DACL, PTOKEN_OWNER and
  PTOKEN_PRIMARY_GROUP as corresponding pointer types to the
  TOKEN_DEFAULT_DACL, TOKEN_OWNER and TOKEN_PRIMARY_GROUP
  base types.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
