From: Corinna Vinschen <vinschen@cygnus.com>
To: cygwin-patches@sources.redhat.com
Subject: [PATCH]: winnt.h, added missing token types and QUOTA_LIMITS
Date: Fri, 18 Aug 2000 17:25:00 -0000
Message-id: <399DD3F7.EEB3F1C0@cygnus.com>
X-SW-Source: 2000-q3/msg00038.html

As mentioned in the subject, I have added two missing token types
`TokenRestrictedSids' and `TokenSessionId' to TOKEN_INFORMATION_CLASS
and I have added the QUOTA_LIMITS, PQUOTA_LIMITS types.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                        mailto:cygwin@sources.redhat.com
Red Hat, Inc.
mailto:vinschen@cygnus.com
