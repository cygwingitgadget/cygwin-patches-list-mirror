From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: [PATCH] (Updated) setup.exe: Stop NetIO_HTTP from treating entire stream as a header
Date: Tue, 27 Nov 2001 23:36:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKOEJNCHAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00275.html
Content-type: multipart/mixed; boundary="----------=_1583532850-65438-120"
Message-ID: <20011127233600.H-gcpiUlgEVW_FHGeB_HOk2euuLACOCtJaliCjYmkEw@z>

This is a multi-part message in MIME format...

------------=_1583532850-65438-120
Content-length: 1091

Ok, with a bit of help from Mr. Tsekov et al, this ought to do it:


2001-11-26  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>

	* nio-http.cc (NetIO_HTTP::NetIO_HTTP): Stop header parsing when
	SimpleSocket::gets() returns a zero-length string, so that we
	don't end up eating the entire stream thinking it's all header info.


Index: nio-http.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/nio-http.cc,v
retrieving revision 2.7
diff -p -u -b -r2.7 nio-http.cc
--- nio-http.cc	2001/11/13 01:49:32	2.7
+++ nio-http.cc	2001/11/28 07:24:49
@@ -180,7 +180,9 @@ retry_get:
       s = 0;
       return;
     }
-  while ((l = s->gets ()) != 0)
+    
+  // Eat the header, picking out the Content-Length in the process
+  while (((l = s->gets ()) != NULL) && (*l != '\0'))
     {
       if (_strnicmp (l, "Content-Length:", 15) == 0)
 	sscanf (l, "%*s %d", &file_size);

-- 
Gary R. Van Sickle
Brewer.  Patriot. 
Attachment:
nio-http.cc-changelog
Description: Binary data
Attachment:
nio-http.cc-patch
Description: Binary data


------------=_1583532850-65438-120
Content-Type: text/plain; charset=us-ascii; name="nio-http.cc-changelog"
Content-Disposition: inline; filename="nio-http.cc-changelog"
Content-Transfer-Encoding: base64
Content-Length: 362

MjAwMS0xMS0yNiAgR2FyeSBSLiBWYW4gU2lja2xlICA8Zy5yLnZhbnNpY2ts
ZUB3b3JsZG5ldC5hdHQubmV0PgoKCSogbmlvLWh0dHAuY2MgKE5ldElPX0hU
VFA6Ok5ldElPX0hUVFApOiBTdG9wIGhlYWRlciBwYXJzaW5nIHdoZW4KCVNp
bXBsZVNvY2tldDo6Z2V0cygpIHJldHVybnMgYSB6ZXJvLWxlbmd0aCBzdHJp
bmcsIHNvIHRoYXQgd2UKCWRvbid0IGVuZCB1cCBlYXRpbmcgdGhlIGVudGly
ZSBzdHJlYW0gdGhpbmtpbmcgaXQncyBhbGwgaGVhZGVyIGluZm8uCg==

------------=_1583532850-65438-120
Content-Type: text/x-diff; charset=us-ascii; name="nio-http.cc-patch"
Content-Disposition: inline; filename="nio-http.cc-patch"
Content-Transfer-Encoding: base64
Content-Length: 810

SW5kZXg6IG5pby1odHRwLmNjCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY2luc3RhbGwvbmlvLWh0dHAu
Y2MsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDIuNwpkaWZmIC1wIC11IC1iIC1y
Mi43IG5pby1odHRwLmNjCi0tLSBuaW8taHR0cC5jYwkyMDAxLzExLzEzIDAx
OjQ5OjMyCTIuNworKysgbmlvLWh0dHAuY2MJMjAwMS8xMS8yOCAwNzoyNDo0
OQpAQCAtMTgwLDcgKzE4MCw5IEBAIHJldHJ5X2dldDoKICAgICAgIHMgPSAw
OwogICAgICAgcmV0dXJuOwogICAgIH0KLSAgd2hpbGUgKChsID0gcy0+Z2V0
cyAoKSkgIT0gMCkKKyAgICAKKyAgLy8gRWF0IHRoZSBoZWFkZXIsIHBpY2tp
bmcgb3V0IHRoZSBDb250ZW50LUxlbmd0aCBpbiB0aGUgcHJvY2VzcworICB3
aGlsZSAoKChsID0gcy0+Z2V0cyAoKSkgIT0gTlVMTCkgJiYgKCpsICE9ICdc
MCcpKQogICAgIHsKICAgICAgIGlmIChfc3RybmljbXAgKGwsICJDb250ZW50
LUxlbmd0aDoiLCAxNSkgPT0gMCkKIAlzc2NhbmYgKGwsICIlKnMgJWQiLCAm
ZmlsZV9zaXplKTsK

------------=_1583532850-65438-120--
