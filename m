Return-Path: <cygwin-patches-return-2251-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27669 invoked by alias); 29 May 2002 02:31:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27631 invoked from network); 29 May 2002 02:31:40 -0000
Message-ID: <FE045D4D9F7AED4CBFF1B3B813C853376762B3@mail.sandvine.com>
From: Don Bowman <don@sandvine.com>
To: "''cygwin-patches@cygwin.com' '" <cygwin-patches@cygwin.com>
Subject: RE: New stat stuff (was [PATCH] improve performance of stat() ope
	 rations (e.g. ls -lR )) 
Date: Tue, 28 May 2002 19:31:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-SW-Source: 2002-q2/txt/msg00234.txt.bz2

For interests sake, here are the file operations done with no
special options (neither environment nor mount) for a ls -l on
a file:

IRP_MJ_CREATE	file SUCCESS		Attributes: Any Options: Open 	
FASTIO_QUERY_BASIC_INFO	file SUCCESS		Attributes: A	
IRP_MJ_CLEANUP	file SUCCESS		
IRP_MJ_CLOSE 	file SUCCESS		
IRP_MJ_CREATE	file SUCCESS		Attributes: RN Options: Open 	
IRP_MJ_QUERY_VOLUME_INFORMATION	file SUCCESS
FileFsVolumeInformation	
IRP_MJ_QUERY_INFORMATION	file BUFFER OVERFLOW	FileAllInformation
IRP_MJ_CLEANUP	file SUCCESS		
IRP_MJ_CLOSE 	file SUCCESS		
IRP_MJ_CREATE	file SUCCESS		Attributes: Any Options: Open 	
FASTIO_QUERY_BASIC_INFO		file SUCCESS		Attributes: A	
IRP_MJ_CLEANUP	file SUCCESS		
IRP_MJ_CLOSE 	file SUCCESS		
IRP_MJ_CREATE	file SUCCESS		Attributes: Any Options: Open 	
IRP_MJ_QUERY_SECURITY		file SUCCESS		
IRP_MJ_CLEANUP	file SUCCESS		
IRP_MJ_CLOSE 	file SUCCESS		
