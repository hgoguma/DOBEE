 //=Create object of FilePicker Constructor function function & set Properties===
    function SetPicker() {
        var picker = new FilePicker(
            {
                apiKey: 'AIzaSyB8YEvmQ3oj0tPg7_RyUeXMhsc5KmfJJTQ',
                clientId: '742532035296-mbiasnqpksnq35hcahvceqi6clc70le8.apps.googleusercontent.com',
                buttonEl: document.getElementById("goGoogleDrive"),
                onClick: function (file) {
                    PopupCenter('https://drive.google.com/file/d/' + file.id + '/view', "", 1026, 500);
                }
            });
    }

    //====================Create POPUP function==============
    function PopupCenter(url, title, w, h) {
        //debugger;
        var left = (screen.width / 2) - (w / 2);
        var top = (screen.height / 2) - (h / 2);
        return window.open(url, title, 'width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
    }

    //===============Create Constructor function==============
    function FilePicker(User) {
        //Configuration
        this.apiKey = User.apiKey;
        this.clientId = User.clientId;

        //Button
        this.buttonEl = User.buttonEl;

        //Click Events
        this.onClick = User.onClick;
        this.buttonEl.addEventListener('click', this.open.bind(this));


        //Disable the button until the API loads, as it won't work properly until then.
        this.buttonEl.disabled = true;

        //Load the drive API
        gapi.client.setApiKey(this.apiKey);
        gapi.client.load('drive', 'v2', this.DriveApiLoaded.bind(this));
        gapi.load('picker', '1', { callback: this.PickerApiLoaded.bind(this) });
    }

    FilePicker.prototype = {
        //==========Check Authentication & Call ShowPicker() function=======

        open: function () {
            // Check if the user has already authenticated
            var token = gapi.auth.getToken();
            if (token) {
                this.ShowPicker();
            } else {
                // The user has not yet authenticated with Google
                // We need to do the authentication before displaying the drive picker.

                this.DoAuth(false, function ()
                { this.ShowPicker(); }.bind(this));
            }
        },

        //========Show the file picker once authentication has been done.=========
        ShowPicker: function () {
            var accessToken = gapi.auth.getToken().access_token;

            //========Show Different Display View in Picker Dialog box=======

            //View all the documents of Google drive
            //var DisplayView = new google.picker.View(google.picker.ViewId.DOCS);


            //View all the documents of a Specific folder of Google drive
            //var DisplayView = new google.picker.DocsView().setParent('PUT YOUR FOLDER ID');


            //View all the documents & folders of google drive
            var DisplayView = new google.picker.DocsView().setIncludeFolders(true);


            //Only view all Folders in Google drive.
            //var DisplayView = new google.picker.DocsView()
            //    .setIncludeFolders(true)
            //    .setMimeTypes('application/vnd.google-apps.folder')
            //    .setSelectFolderEnabled(true);


            //Use DocsUploadView to upload documents to Google Drive.
            //var UploadView = new google.picker.DocsUploadView();

            //addViewGroup(new google.picker.ViewGroup(google.picker.ViewId.DOCS).
            // addView(google.picker.ViewId.DOCUMENTS).
            // addView(google.picker.ViewId.PRESENTATIONS)).


            //========Show Different Upload View in Picker Dialog box=======

            //User can upload file in any folder (by select folder)
            var UploadView = new google.picker.DocsUploadView().setIncludeFolders(true);

            //User can upload file in specific folder
            //var UploadView = new google.picker.DocsUploadView().setParent('PUT YOUR FOLDER ID')

            this.picker = new google.picker.PickerBuilder().
                addView(DisplayView).
                enableFeature(google.picker.Feature.MULTISELECT_ENABLED).
                setAppId(this.clientId).
                addView(UploadView).
                setOAuthToken(accessToken).
                setCallback(this.PickerResponse.bind(this)).
                setTitle('구글드라이브 UPLOAD').
                build().
                setVisible(true);
            
        },

        //====Called when a file has been selected in the Google Picker Dialog Box======
        PickerResponse: function (data) {
            if (data[google.picker.Response.ACTION] == google.picker.Action.PICKED) {
                var file = data[google.picker.Response.DOCUMENTS][0],
                    id = file[google.picker.Document.ID],
                    request = gapi.client.drive.files.get({ fileId: id });
                //this.ShowPicker(); 
                //request.execute(this.GetFileDetails.bind(this));
                var link = "https://drive.google.com/open?id="+id;
				var filename = file.name;
				
                document.getElementById('down').innerHTML = "<a href="+link+ ">"+ "<i class='fab fa-google-drive'></i>"+filename+"</a>";
            }
        },

        //====Called when file details have been retrieved from Google Drive========
        GetFileDetails: function (file) {
            if (this.onClick) {
                this.onClick(file);
                
                console.log("방금 이거");

				



                
            }
        },

        //====Called when the Google Drive file picker API has finished loading.=======
        PickerApiLoaded: function () {
            this.buttonEl.disabled = false;
        },

        //========Called when the Google Drive API has finished loading.==========
        DriveApiLoaded: function () {
            this.DoAuth(true);
        },

        //========Authenticate with Google Drive via the Google Picker API.=====
        DoAuth: function (immediate, callback) {
            gapi.auth.authorize({
                client_id: this.clientId,
                scope: 'https://www.googleapis.com/auth/drive',
                immediate: immediate
            }, callback);
        }
    };