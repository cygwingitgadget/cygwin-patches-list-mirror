Return-Path: <cygwin-patches-return-4541-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8318 invoked by alias); 30 Jan 2004 11:06:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8245 invoked from network); 30 Jan 2004 11:06:02 -0000
Message-ID: <CB2B5D9D2710D611A79100025558212EF23A75@geacprg.cz.geac.com>
From: Jiri Malak <Jiri.Malak@geac.cz>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Patch winuser.h in w32api
Date: Fri, 30 Jan 2004 11:06:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
X-SW-Source: 2004-q1/txt/msg00031.txt.bz2

I am working on Open Watcom open source project which use w32api.
I need correct winuser.h header file in w32api.

Original line

#define RT_MANIFEST MAKEINTRESOURCE(24)

to 

#ifndef RC_INVOKED
#define RT_MANIFEST MAKEINTRESOURCE(24)
#else
#define RT_MANIFEST 24
#define CREATEPROCESS_MANIFEST_RESOURCE_ID 1
#define ISOLATIONAWARE_MANIFEST_RESOURCE_ID 2
#define ISOLATIONAWARE_NOSTATICIMPORT_MANIFEST_RESOURCE_ID 3
#endif

Please, could you change it if it is possible.

Thanks

Jiri
