Return-Path: <cygwin-patches-return-3829-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19607 invoked by alias); 26 Apr 2003 14:14:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19594 invoked from network); 26 Apr 2003 14:14:27 -0000
Date: Sat, 26 Apr 2003 14:14:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: Patched GUI mode doc
Message-ID: <20030426141600.GA1460@world-gov>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q2/txt/msg00056.txt.bz2


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 266

I checked in this patch to update the User's Guide discussion of
building GUI Mode Applications.

2003-04-26  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>

        * gcc.sgml: Remove outdated "WinMainCRTStartup" references. Add a
        hellogui.c example. 


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gui-patch.diff"
Content-length: 3268

Index: gcc.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/gcc.sgml,v
retrieving revision 1.2
diff -u -p -r1.2 gcc.sgml
--- gcc.sgml	4 Dec 2001 04:20:30 -0000	1.2
+++ gcc.sgml	26 Apr 2003 14:04:32 -0000
@@ -38,17 +38,6 @@ int
 foo (int i)
 </screen>
 
-<para>For most cases, you can just remove the __export and leave it at
-that.  For convenience sake, you might want to include the following
-code snippet when compiling GUI programs.  If you don't, you will want
-to add "-e _mainCRTStartup" to your link line in your Makefile.</para>
-
-<screen>
-#ifdef __CYGWIN__
-WinMainCRTStartup() { mainCRTStartup(); }
-#endif
-</screen>
-
 <para>The Makefile is similar to any other UNIX-like Makefile,
 and like any other Cygwin makefile.  The only difference is that you use
 <command>gcc -mwindows</command> to link your program into a GUI
@@ -73,6 +62,93 @@ compatibility with the many examples tha
 handle Windows resource files directly, we maintain the
 <filename>.res</filename> naming convention.  For more information on
 <filename>windres</filename>, consult the Binutils manual.  </para>
+
+<para>
+The following is a simple GUI-mode "Hello, World!" program to help
+get you started:
+<screen>
+/*-------------------------------------------------*/
+/* hellogui.c - gui hello world                    */
+/* build: gcc -mwindows hellogui.c -o hellogui.exe */
+/*-------------------------------------------------*/
+#include &lt;windows.h&gt;
+
+char glpszText[1024];
+
+LRESULT CALLBACK WndProc(HWND, UINT, WPARAM, LPARAM);
+
+int APIENTRY WinMain(HINSTANCE hInstance, 
+		HINSTANCE hPrevInstance,
+		LPSTR lpCmdLine,
+		int nCmdShow)
+{
+	sprintf(glpszText, 
+		"Hello World\nGetCommandLine(): [%s]\n"
+		"WinMain lpCmdLine: [%s]\n",
+		lpCmdLine, GetCommandLine() );
+
+	WNDCLASSEX wcex; 
+ 
+	wcex.cbSize = sizeof(wcex);
+	wcex.style = CS_HREDRAW | CS_VREDRAW;
+	wcex.lpfnWndProc = WndProc;
+	wcex.cbClsExtra = 0;
+	wcex.cbWndExtra = 0;
+	wcex.hInstance = hInstance;
+	wcex.hIcon = LoadIcon(NULL, IDI_APPLICATION);
+	wcex.hCursor = LoadCursor(NULL, IDC_ARROW);
+	wcex.hbrBackground = (HBRUSH)(COLOR_WINDOW+1);
+	wcex.lpszMenuName = NULL;
+	wcex.lpszClassName = "HELLO";
+	wcex.hIconSm = NULL;
+
+	if (!RegisterClassEx(&amp;wcex))
+		return FALSE; 
+
+	HWND hWnd;
+	hWnd = CreateWindow("HELLO", "Hello", WS_OVERLAPPEDWINDOW,
+		CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, NULL, NULL, hInstance, NULL);
+
+	if (!hWnd)
+		return FALSE;
+
+	ShowWindow(hWnd, nCmdShow);
+	UpdateWindow(hWnd);
+
+	MSG msg;
+	while (GetMessage(&amp;msg, NULL, 0, 0)) 
+	{
+		TranslateMessage(&amp;msg);
+		DispatchMessage(&amp;msg);
+	}
+
+	return msg.wParam;
+}
+
+LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
+{
+	PAINTSTRUCT ps;
+	HDC hdc;
+	
+	switch (message) 
+	{
+		case WM_PAINT:
+			hdc = BeginPaint(hWnd, &amp;ps);
+			RECT rt;
+			GetClientRect(hWnd, &amp;rt);
+			DrawText(hdc, glpszText, strlen(glpszText), &amp;rt, DT_TOP | DT_LEFT);
+			EndPaint(hWnd, &amp;ps);
+			break;
+		case WM_DESTROY:
+			PostQuitMessage(0);
+			break;
+		default:
+			return DefWindowProc(hWnd, message, wParam, lParam);
+	}
+	return 0;
+}
+</screen>
+</para>
 
 </sect2>
 </sect1>

--6c2NcOVqGQ03X4Wi--
