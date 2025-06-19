export class Issues {
  data?: IssuesData[] = [];
  page?: number = 0;
  success?: boolean = false;
  total?: number = 0;
}

export class IssuesDataLabels {
  name?: string = "";
  color?: string = "";
}

export class IssuesDataPull_request {
  url?: string = "";
  html_url?: string = "";
  diff_url?: string = "";
  patch_url?: string = "";
}

export class IssuesData {
  id?: number = 0;
  number?: number = 0;
  title?: string = "";
  labels?: IssuesDataLabels[] = [];
  state?: string = "";
  locked?: boolean = false;
  comments?: number = 0;
  created_at?: number = 0;
  updated_at?: number = 0;
  closed_at?: string = "";
  author_association?: string = "";
  user?: string = "";
  avatar?: string = "";
  pull_request?: IssuesDataPull_request = new IssuesDataPull_request();
}