import { Controller } from 'stimulus'
import Chart from 'chart.js';

export default class extends Controller {
  static targets = ["container"]

  connect() {
    console.log(JSON.parse(this.chartData))

    new Chart(this.containerTarget, {
      type: 'line',
      options: {
        aspectRatio: 1
      },
      data: {
        datasets: [
          {
            label: "Annual sales",
            data: JSON.parse(this.chartData)
          }
        ]
      }
    });
  }

  get chartData() {
    return this.data.get('numbers');
  }


  // createPpChart() {
  //   let path;
  //   if (this.paramTarget) {
  //     path = `/pps.json${this.paramTarget.dataset.ppParam}`;
  //   } else {
  //     path = '/pps.json';
  //   }
  //   this.initChart(path, this.ppsChartTarget);
  // }
  // createUsersChart() {
  //   const path = '/users.json';
  //   this.initChart(path, this.usersChartTarget);
  // }
}
