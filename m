Return-Path: <cygwin-patches-return-4889-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30534 invoked by alias); 10 Aug 2004 10:36:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30518 invoked from network); 10 Aug 2004 10:36:42 -0000
X-Originating-IP: 141.228.156.225
From: Charles Reindorf <charles@reindorf.com>
To: cygwin-patches@cygwin.com
Date: Tue, 10 Aug 2004 10:36:00 -0000
Subject: array size problem in select.cc
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-Qmail-Scanner-Message-ID: <109213420166130361@lon3.mailcustodian.co.uk>
X-SW-Source: 2004-q3/txt/msg00041.txt.bz2
Message-ID: <20040810103600.UcV2Eun7D4mHAdBTrt-WoJorre3boPoG6EBXQDxMMNE@z>


Cygwin developers,

I was browsing in "winsup/cygwin/select.cc" from snapshot 20040808-1 and I
think I see an array size problem there, resutling in possible core dumps when
selecting about 63 file descriptors. I wonder if the following patch is
applicable?

-- Charles Reindorf.

*** ../cygwin.bak/select.cc	Tue Aug 10 11:27:26 2004
--- select.cc	Tue Aug 10 11:27:38 2004
***************
*** 223,229 ****
  		    DWORD ms)
  {
    int wait_ret;
!   HANDLE w4[MAXIMUM_WAIT_OBJECTS];
    select_record *s = &start;
    int m = 0;
    int res = 0;
--- 223,229 ----
  		    DWORD ms)
  {
    int wait_ret;
!   HANDLE w4[MAXIMUM_WAIT_OBJECTS+1];
    select_record *s = &start;
    int m = 0;
    int res = 0;

